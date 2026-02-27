import OpenAPIURLSession

final class TestRouteStationsService {

    static func testFetchRouteStations() {
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = RouteStationsService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching route stations...")
                let route = try await service.getRouteStations(
                    uid: "5N-237_260226_c80_12"
                )
                
                print("Successfully fetched route stations: \(route)")
            } catch {
                print("Error fetching route stations: \(error)")
            }
        }
    }
}

