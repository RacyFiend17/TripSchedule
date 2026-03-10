import OpenAPIURLSession
import Foundation

actor NetworkClient {
    private let allStationsService: AllStationsServiceProtocol
    private let scheduleService: ScheduleBetweenStationsServiceProtocol
    private let carrierService: CarrierInfoServiceProtocol

    init(
        allStationsService: AllStationsServiceProtocol,
        scheduleService: ScheduleBetweenStationsServiceProtocol,
        carrierService: CarrierInfoServiceProtocol
    ) {
        self.allStationsService = allStationsService
        self.scheduleService = scheduleService
        self.carrierService = carrierService
    }

    // MARK: Methods
    func fetchAllStations() async throws -> AllStations {
        try await allStationsService.getAllStations()
    }

    func fetchSchedule(from: String, to: String) async throws -> Segments {
        try await scheduleService.getScheduleBetweenStations(from: from, to: to)
    }

    func fetchCarrierInfo(code: String, system: String) async throws -> Carrier {
        try await carrierService.getCarrierInfo(code: code, system: system)
    }
}

// MARK: Singletone
enum NetworkClientProvider {
    static let shared: NetworkClient = {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            let apiKey = Constants.apiKey
            return NetworkClient(
                allStationsService: AllStationsService(client: client, apiKey: apiKey),
                scheduleService: ScheduleBetweenStationsService(client: client, apiKey: apiKey),
                carrierService: CarrierInfoService(client: client, apiKey: apiKey)
            )
        } catch {
            fatalError("Failed to create NetworkClient: \(error)")
        }
    }()
}

extension NetworkClient {
    
    func fetchAllCities() async throws -> [City] {
        let allStations = try await fetchAllStations()
        
        let settlements: [Components.Schemas.Settlement] = allStations.countries?
            .compactMap { $0 }
            .flatMap { $0.regions ?? [] }
            .compactMap { $0 }
            .flatMap { $0.settlements ?? [] }
            .compactMap { $0 }
            ?? []

        let cities: [City] = settlements.map { settlement in
            let cityName = (settlement.title ?? "Без названия").trimmingCharacters(in: .whitespacesAndNewlines)
            return City(
                id: settlement.codes?.yandex_code ?? UUID().uuidString,
                name: cityName.isEmpty ? "Без названия" : cityName,
                stations: settlement.stations?.compactMap { station in
                    guard let codes = station.codes else { return nil }
                    return Station(
                        id: codes.yandex_code ?? UUID().uuidString,
                        name: station.title ?? "Без названия",
                        stationType: station.station_type_name ?? "Unknown",
                        transportType: station.transport_type ?? "Unknown"
                    )
                } ?? []
            )
        }
        
//        let sortedCities = cities.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        let sortedCities = cities
        
        return sortedCities
        
    }
}

