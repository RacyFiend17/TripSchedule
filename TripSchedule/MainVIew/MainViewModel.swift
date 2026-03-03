import Observation

@Observable final class MainViewModel {
    
    var fromCity: City?
    var fromStation: Station?
    
    var toCity: City?
    var toStation: Station?
    
    var isSearchEnabled: Bool {
        fromStation != nil && toStation != nil
    }
    
    func swapDirections() {
        swap(&fromCity, &toCity)
        swap(&fromStation, &toStation)
    }
}
