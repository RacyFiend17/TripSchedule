import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> ThreadStations
}

final class RouteStationsService: BaseService, RouteStationsServiceProtocol {
    
    func getRouteStations(uid: String) async throws -> ThreadStations {
        
        let response = try await client.getRouteStations(query: .init(
            apikey: apiKey,
            uid: uid
        ))
        
        return try response.ok.body.json
    }
}
