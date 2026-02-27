import OpenAPIURLSession

final class TestCarrierInfoService {

    static func testFetchCarrierInfo() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CarrierInfoService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Fetching carrier info...")
                let carrier = try await service.getCarrierInfo(
                    code: "TK",
                    system: "iata"
                )
                
                print("Successfully fetched carrier info: \(carrier)")
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
}
