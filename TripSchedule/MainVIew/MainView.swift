import SwiftUI

struct MainView: View {
    @State private var selectedCity: City?
    @State private var selectedStation: Station?
    
    @State private var path: [Route] = []
    
    enum Route: Hashable {
        case cities
        case stations(City?)
    }
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            Text(selectedCity?.name ?? "Город еще не выбран")
            Text(selectedStation?.name ?? "Станция еще не выбрана")
            
            Button("Открыть экран c выбором города") {
                path.append(Route.cities)
            }
            .navigationDestination(for: Route.self) { value in
                
                if value == Route.cities {
                    SelectionView(title: "Выбор города", items: MockDataProvider.cities) { item in
                        selectedCity = item
                        path.append(Route.stations(item))
                    }
                }
                
                if value == Route.stations(selectedCity) {
                    SelectionView(title: "Выбор станции", items: selectedCity?.stations ?? []) { item in
                        selectedStation = item
                        path = []
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    MainView()
}
