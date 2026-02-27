import OpenAPIURLSession

final class TestCopyrightService {

    static func testCopyright() {
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CopyrightService(
                    client: client,
                    apiKey: Constants.apiKey
                )
                
                print("Copyrighting...")
                let schedule = try await service.copyright()
                
                print("Successfully copyrighted: \(schedule)")
            } catch {
                print("Error when copyrighting: \(error)")
            }
        }
    }
}

