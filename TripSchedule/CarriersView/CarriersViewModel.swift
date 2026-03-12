import Observation
import Foundation

@Observable
@MainActor
final class CarriersViewModel {

    var selectedTimes: Set<TimeFilter> = []
    var transferFilter: TransferFilter?
    var selectedRoute: Route?

    let fromStation: Station
    let toStation: Station

    private(set) var routes: [Route] = []

    var isLoading = false
    var onError: (AppErrorType) -> Void

    var hasActiveFilter: Bool {
        !selectedTimes.isEmpty || transferFilter != nil
    }

    var filteredRoutes: [Route] {
        routes.filter { route in
            matchesTransfer(route) &&
            matchesTime(route)
        }
    }

    init(
        from: Station,
        to: Station,
        onError: @escaping (AppErrorType) -> Void
    ) {
        self.fromStation = from
        self.toStation = to
        self.onError = onError
    }

    func loadRoutes(from stationFrom: Station, to stationTo: Station) async {

        isLoading = true

        do {
            let response = try await NetworkClientProvider.shared.fetchSchedule(
                from: stationFrom.id,
                to: stationTo.id
            )

            let segments = response.segments ?? []

            routes = segments.map { Route(segment: $0) }

        } catch {
            
            if Task.isCancelled {
                return
            }

            await MainActor.run {
                self.isLoading = false
                self.onError(mapNetworkError(error))
            }
        }

        isLoading = false
    }

    private func matchesTransfer(_ route: Route) -> Bool {
        guard let transferFilter else { return true }

        switch transferFilter {
        case .noTransfer:
            return !route.isTransfer
        case .yesTransfer:
            return true
        }
    }

    private func matchesTime(_ route: Route) -> Bool {

        guard !selectedTimes.isEmpty else { return true }

        guard let hour = route.departureHour else {
            return false
        }

        return selectedTimes.contains { item in
            switch item {
            case .morning:
                return hour >= 6 && hour < 12
            case .day:
                return hour >= 12 && hour < 18
            case .evening:
                return hour >= 18 && hour < 24
            case .night:
                return hour >= 0 && hour < 6
            }
        }
    }
}
