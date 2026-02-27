import OpenAPIURLSession

final class TestScheduleBetweenStationsService {

    static func testFetchScheduleBetweenStations() {
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = ScheduleBetweenStationsService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching schedule between stations...")
                let schedule = try await service.getScheduleBetweenStations(
                    from: "c146",
                    to: "c213"
                )
                
                print("Successfully fetched schedule between stations: \(schedule)")
            } catch {
                print("Error fetching schedule between stations: \(error)")
            }
        }
    }
}

