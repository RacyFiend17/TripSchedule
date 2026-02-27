import OpenAPIURLSession

final class TestNearestStationService {

    static func testFetchNearestStations() {
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestStationsService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching nearest stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50    
                )
                
                print("Successfully fetched nearest stations: \(stations)")
            } catch {
                print("Error fetching nearest stations: \(error)")
            }
        }
    }
}
