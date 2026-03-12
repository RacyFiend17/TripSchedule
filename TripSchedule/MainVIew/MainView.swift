import SwiftUI

struct MainView: View {
    @State private var selectedCity: City?
    @State private var selectedStation: Station?
    @State private var mainViewModel = MainViewModel()
    @State private var carriersViewModel: CarriersViewModel?
    
    @Binding var path: [MainPath]
    
    var onError: (AppErrorType) -> Void
    
    var body: some View {
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
                            path.append(MainPath.fromCity)
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
                            path.append(MainPath.toCity)
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
                        carriersViewModel = CarriersViewModel(from: fromStation, to: toStation) { error in
                            onError(error)
                        }
                        path.append(MainPath.search)
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
        .navigationDestination(for: MainPath.self) { value in
            
            switch value {
                
            case MainPath.fromCity:
                SelectionView(
                    title: "Выбор города",
                    viewModel: SelectionViewModel(fetchItems: {
                        try await mainViewModel.getAllCities()
                    }, onError: { error in
                        onError(error)
                    }
                                                 ),
                    onSelect: { city in
                        mainViewModel.fromCity = city
                        path.append(MainPath.fromStation)
                    }
                )
                .toolbar(.hidden, for: .tabBar)
                
            case MainPath.fromStation:
                if let fromCity = mainViewModel.fromCity {
                    SelectionView(
                        title: "Выбор станции",
                        viewModel: SelectionViewModel(fetchItems: {
                            fromCity.stations
                        }, onError: { error in
                            onError(error)
                        }
                                                     ),
                        onSelect: { station in
                            mainViewModel.fromStation = station
                            
                            if let toStation = mainViewModel.toStation {
                                carriersViewModel = CarriersViewModel(from: station, to: toStation) { error in
                                    onError(error)
                                }
                            }
                            
                            path = []
                        }
                    )
                    .toolbar(.hidden, for: .tabBar)
                }
                
            case MainPath.toCity:
                SelectionView(
                    title: "Выбор города",
                    viewModel: SelectionViewModel(fetchItems: {
                        try await mainViewModel.getAllCities()
                    }, onError: { error in
                        onError(error)
                    }
                                                 ),
                    onSelect: { city in
                        mainViewModel.toCity = city
                        path.append(MainPath.toStation)
                    }
                )
                .toolbar(.hidden, for: .tabBar)
                
            case MainPath.toStation:
                if let toCity = mainViewModel.toCity {
                    SelectionView(
                        title: "Выбор станции",
                        viewModel: SelectionViewModel(fetchItems: {
                            toCity.stations
                        }, onError: { error in
                            onError(error)
                        }
                                                     ),
                        onSelect: { station in
                            mainViewModel.toStation = station
                            
                            if let fromStation = mainViewModel.fromStation {
                                carriersViewModel = CarriersViewModel(from: fromStation, to: station) { error in
                                    onError(error)
                                }
                            }
                            
                            path.removeAll()
                        }
                    )
                    .toolbar(.hidden, for: .tabBar)
                }
                
            case MainPath.search:
                if let carriersViewModel = carriersViewModel,
                   let fromStation = mainViewModel.fromStation,
                   let toStation = mainViewModel.toStation
                {
                    CarriersView(
                        title: "\(fromStation.name) → \(toStation.name)",
                        viewModel: carriersViewModel,
                        onCarrierCardSelect: { path.append(MainPath.carrierInfo) },
                        onFilterSelect: { path.append(MainPath.filters) }
                    )
                    .toolbar(.hidden, for: .tabBar)
                    .task {
                        await carriersViewModel.loadRoutes(from: fromStation, to: toStation)
                    }
                } else {
                    Text("Выберите станции для поиска")
                        .foregroundColor(.gray)
                }
                
            case MainPath.filters:
                if let carriersViewModel = carriersViewModel {
                    FiltersView(viewModel: carriersViewModel)
                } else {
                    Text("Фильтры недоступны")
                }
                
            case MainPath.carrierInfo:
                if let carriersViewModel = carriersViewModel {
                    CarrierInfo(viewModel: carriersViewModel)
                } else {
                    Text("Информация о перевозчике недоступна")
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
