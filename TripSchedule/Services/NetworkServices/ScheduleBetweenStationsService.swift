import OpenAPIRuntime
import OpenAPIURLSession

typealias Segments = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> Segments
}

final class ScheduleBetweenStationsService: BaseService, ScheduleBetweenStationsServiceProtocol {
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> Segments {
        
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apiKey,
            from: from,
            to: to,
        ))
        
        return try response.ok.body.json
    }
}
