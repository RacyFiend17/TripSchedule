import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String, system: String) async throws -> Carrier
}

final class CarrierInfoService: BaseService, CarrierInfoServiceProtocol {
    
    func getCarrierInfo(code: String, system: String) async throws -> Carrier{
        
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code,
            system: system
        ))
        
        return try response.ok.body.json
    }
}
