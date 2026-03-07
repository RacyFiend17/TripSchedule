import Observation

@Observable final class CarriersViewModel {
    
    var selectedTimes: Set<TimeFilter> = []
    var transferFilter: TransferFilter?
    var selectedRoute: Route?
    
    private var routes: [Route] = MockDataProvider.routes
    
    var hasActiveFilter: Bool {
        !selectedTimes.isEmpty || transferFilter != nil
    }
    
    var filteredRoutes: [Route] {
        routes.filter { route in
            matchesTransfer(route) &&
            matchesTime(route)
        }
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

