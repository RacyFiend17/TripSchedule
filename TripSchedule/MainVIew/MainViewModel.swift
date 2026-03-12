import Observation

@Observable
@MainActor
final class MainViewModel {
    
    var fromCity: City?
    var fromStation: Station?
    
    var toCity: City?
    var toStation: Station?
    
    var isSearchEnabled: Bool {
        fromStation != nil && toStation != nil
    }
    
    private(set) var allCitiesCache: [City]?
    
    func swapDirections() {
        swap(&fromCity, &toCity)
        swap(&fromStation, &toStation)
    }
    
    func getAllCities() async throws -> [City] {
        return try await withTaskCancellationHandler {
            try Task.checkCancellation()
            
            if let cached = allCitiesCache {
                return cached
            }
            
            try Task.checkCancellation()
            
            let cities = try await NetworkClientProvider.shared.fetchAllCities()
            
            try Task.checkCancellation()
            
            allCitiesCache = cities
            return cities
        } onCancel: {
            print("Запрос getAllCities отменен")
        }
    }
}

