import OpenAPIURLSession

final class TestAllStationService {

    static func testFetchAllStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = AllStationsService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching all stations...")
                let stations = try await service.getAllStations()
                
                print("Successfully fetched all stations: \(stations)")
            } catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
}
