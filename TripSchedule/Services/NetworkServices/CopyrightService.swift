import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func copyright() async throws -> Copyright
}

final class CopyrightService: BaseService, CopyrightServiceProtocol {
    
    func copyright() async throws -> Copyright {
        
        let response = try await client.copyright(query: .init(
            apikey: apiKey
        ))
        
        return try response.ok.body.json
    }
}
