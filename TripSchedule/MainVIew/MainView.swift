import SwiftUI

struct MainView: View {
    @State private var selectedCity: City?
    @State private var selectedStation: Station?
    
    @State private var mainViewModel = MainViewModel()
    @State private var carriersViewModel = CarriersViewModel()
    
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack (alignment: .center, spacing: 20){
                ScrollView {
                    LazyHStack {
                        
                    }
                }
                .padding([.bottom, .top], 24)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, maxHeight: 188, alignment: .init(horizontal: .center, vertical: .top))
                
                VStack(spacing: 16) {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Button() {
                                path.append("FromCity")
                            } label:
                            {
                                Text(mainViewModel.fromStation?.name ?? "Откуда")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(mainViewModel.fromStation?.name != nil ? Color(.black) : Color(.ypGray))
                                    .padding(.leading, 16)
                                    .padding(.trailing, 13)
                                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(Color.white)
                            
                            Button() {
                                path.append("ToCity")
                            } label:
                            {
                                Text(mainViewModel.toStation?.name ?? "Куда")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(mainViewModel.toStation?.name != nil ? Color(.black) : Color(.ypGray))
                                    .padding(.leading, 16)
                                    .padding(.trailing, 13)
                                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(Color.white)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 128)
                        .cornerRadius(20)
                        .padding([.leading, .top, .bottom], 16)
                        
                        
                        Button() {
                            mainViewModel.swapDirections()
                        } label: {
                            Image("changeIcon")
                                .resizable()
                                .frame(width: 36, height: 36)
                                .padding(.horizontal, 16)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 128)
                    .background(Color(.ypBlue))
                    .cornerRadius(20)
                    .padding(.horizontal, 16)
                    
                    if mainViewModel.isSearchEnabled{
                        Button() {
                            path.append("Search")
                        } label: {
                            Text("Найти")
                                .font(.system(size: 17, weight: .bold))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .init(horizontal: .center, vertical: .center))
                            
                        }
                        .frame(maxWidth: 150, maxHeight: 60)
                        .background(Color.ypBlue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                    }
                }
                Spacer()
            }
            .background(Color(.ypWhite))
            .navigationDestination(for: String.self) { value in
                
                switch value {
                    
                case "FromCity":
                    SelectionView(title: "Выбор города",
                                  items: MockDataProvider.cities) { item in
                        mainViewModel.fromCity = item
                        path.append("FromStation")
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case "FromStation":
                    SelectionView(title: "Выбор станции",
                                  items: mainViewModel.fromCity?.stations ?? []) { item in
                        mainViewModel.fromStation = item
                        path = []
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case "ToCity":
                    SelectionView(title: "Выбор города",
                                  items: MockDataProvider.cities) { item in
                        mainViewModel.toCity = item
                        path.append("ToStation")
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case "ToStation":
                    SelectionView(title: "Выбор станции",
                                  items: mainViewModel.toCity?.stations ?? []) { item in
                        mainViewModel.toStation = item
                        path = []
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case "Search":
                    if let fromCity = mainViewModel.fromCity,
                       let fromStation = mainViewModel.fromStation,
                       let toCity = mainViewModel.toCity,
                       let toStation = mainViewModel.toStation
                    {
                        CarriersView(title: "\(fromCity.name)" + " " + "(\(fromStation.name))" + " " + "→" + " " + "\(toCity.name)" + " " + "(\(toStation.name))", viewModel: carriersViewModel) {
                            path.append("Filters")
                        }
                        .toolbar(.hidden, for: .tabBar)
                    }
                    
                case "Filters":
                    FiltersView(viewModel: carriersViewModel)
                        .toolbar(.hidden, for: .tabBar)
                default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

#Preview {
    MainView()
}
