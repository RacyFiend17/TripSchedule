import OpenAPIURLSession

final class TestNearestCityService {

    static func testFetchNearestCity() {
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestCityService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching nearest city...")
                let stations = try await service.getNearestCity(
                    lat: 59.864177, 
                    lng: 30.319163,
                )
                
                print("Successfully fetched nearest city: \(stations)")
            } catch {
                print("Error fetching nearest city: \(error)")
            }
        }
    }
}
