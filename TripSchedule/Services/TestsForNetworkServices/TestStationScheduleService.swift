import OpenAPIURLSession

final class TestStationScheduleService {

    static func testFetchStationSchedule() {
        Task {
            do {

                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = StationScheduleService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching station schedule...")
                let schedule = try await service.getStationSchedule(
                    station: "s9600213",
                )
                
                print("Successfully fetched station schedule: \(schedule)")
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }
}

