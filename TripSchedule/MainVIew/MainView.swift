import SwiftUI

struct MainView: View {
    @State private var selectedCity: City?
    @State private var selectedStation: Station?
    @State private var mainViewModel = MainViewModel()
    @State private var carriersViewModel: CarriersViewModel?
    
    @State private var path: [Path] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack (spacing: 20) {
                ScrollView(.horizontal) {
                    LazyHStack (spacing: 12) {
                        ForEach(MockDataProvider.storiesPacks){ storyPack in
                            NavigationLink {
                                StoriesView(storiesPack: storyPack)
                                    .toolbar(.hidden, for: .tabBar)
                                    .navigationBarBackButtonHidden(true)
                                    .navigationTitle("")
                                    .toolbarRole(.editor)
                            } label: {
                                StoryPreview(storyPack: storyPack)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding([.bottom, .top], 24)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: 188)
                
                VStack(spacing: 16) {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Button {
                                path.append(Path.fromCity)
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
                                path.append(Path.toCity)
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
                            Image(.changeIcon)
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
                        Button {
                            guard
                                let fromStation = mainViewModel.fromStation,
                                let toStation = mainViewModel.toStation else {
                                return
                            }
                            carriersViewModel = CarriersViewModel(from: fromStation, to: toStation) {
                                path.append(Path.serverError)
                            }
                            path.append(Path.search)
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
            .navigationDestination(for: Path.self) { value in
                
                switch value {
                    
                case Path.fromCity:
                    SelectionView(
                        title: "Выбор города",
                        viewModel: SelectionViewModel(fetchItems: {
                            try await mainViewModel.getAllCities()
                        }, onServerError: {
                            path.removeAll()
                            path.append(Path.serverError)
                        }
                                                     ),
                        onSelect: { city in
                            mainViewModel.fromCity = city
                            path.append(Path.fromStation)
                        }
                    )
                    .toolbar(.hidden, for: .tabBar)
                    
                case Path.fromStation:
                    if let fromCity = mainViewModel.fromCity {
                        SelectionView(
                            title: "Выбор станции",
                            viewModel: SelectionViewModel(fetchItems: {
                                fromCity.stations
                            }, onServerError: {
                                path.removeAll()
                                path.append(Path.serverError)
                            }
                                                         ),
                            onSelect: { station in
                                mainViewModel.fromStation = station
                                
                                if let toStation = mainViewModel.toStation {
                                    carriersViewModel = CarriersViewModel(from: station, to: toStation){
                                        path.append(Path.serverError)
                                    }
                                }
                                
                                path = []
                            }
                        )
                        .toolbar(.hidden, for: .tabBar)
                    }
                    
                case Path.toCity:
                    SelectionView(
                        title: "Выбор города",
                        viewModel: SelectionViewModel(fetchItems: {
                            try await mainViewModel.getAllCities()
                        }, onServerError: {
                            path.removeAll()
                            path.append(Path.serverError)
                        }
                                                     ),
                        onSelect: { city in
                            mainViewModel.toCity = city
                            path.append(Path.toStation)
                        }
                    )
                    .toolbar(.hidden, for: .tabBar)
                    
                case Path.toStation:
                    if let toCity = mainViewModel.toCity {
                        SelectionView(
                            title: "Выбор станции",
                            viewModel: SelectionViewModel(fetchItems: {
                                toCity.stations
                            }, onServerError: {
                                path.removeAll()
                                path.append(Path.serverError)
                            }
                                                         ),
                            onSelect: { station in
                                mainViewModel.toStation = station
                                
                                if let fromStation = mainViewModel.fromStation {
                                    carriersViewModel = CarriersViewModel(from: fromStation, to: station){
                                        path.append(Path.serverError)
                                    }
                                }
                                
                                path.removeAll()
                            }
                        )
                        .toolbar(.hidden, for: .tabBar)
                    }
                    
                case Path.search:
                    if let carriersViewModel = carriersViewModel,
                       let fromStation = mainViewModel.fromStation,
                       let toStation = mainViewModel.toStation
                    {
                        CarriersView(
                            title: "\(fromStation.name) → \(toStation.name)",
                            viewModel: carriersViewModel,
                            onCarrierCardSelect: { path.append(Path.carrierInfo) },
                            onFilterSelect: { path.append(Path.filters) }
                        )
                        .toolbar(.hidden, for: .tabBar)
                        .task {
                            await carriersViewModel.loadRoutes(from: fromStation, to: toStation)
                        }
                    } else {
                        Text("Выберите станции для поиска")
                            .foregroundColor(.gray)
                    }
                    
                case Path.filters:
                    if let carriersViewModel = carriersViewModel {
                        FiltersView(viewModel: carriersViewModel)
                    } else {
                        Text("Фильтры недоступны")
                    }
                    
                case Path.carrierInfo:
                    if let carriersViewModel = carriersViewModel {
                        CarrierInfo(viewModel: carriersViewModel)
                    } else {
                        Text("Информация о перевозчике недоступна")
                    }
                case Path.userAgreement:
                    UserAgreementView()
                        .toolbar(.hidden, for: .tabBar)
                    
                case Path.serverError:
                    let errorViewModel = ErrorViewModel(errorType: .serverError)
                    ErrorView(viewModel: errorViewModel)
                        .navigationBarBackButtonHidden(true)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
