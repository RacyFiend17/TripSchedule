import SwiftUI

struct MainView: View {
    @State private var selectedCity: City?
    @State private var selectedStation: Station?
    
    @State private var mainViewModel = MainViewModel()
    @State private var carriersViewModel = CarriersViewModel()
    
    @State private var path: [Path] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack (spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
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
                .frame(maxWidth: .infinity, maxHeight: 188)
                
                VStack(spacing: 16) {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Button() {
                                path.append(Path.FromCity)
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
                                path.append(Path.ToCity)
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
                        Button() {
                            path.append(Path.Search)
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
                    
                case Path.FromCity:
                    SelectionView(title: "Выбор города",
                                  items: MockDataProvider.cities) { item in
                        mainViewModel.fromCity = item
                        path.append(Path.FromStation)
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case Path.FromStation:
                    SelectionView(title: "Выбор станции",
                                  items: mainViewModel.fromCity?.stations ?? []) { item in
                        mainViewModel.fromStation = item
                        path = []
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case Path.ToCity:
                    SelectionView(title: "Выбор города",
                                  items: MockDataProvider.cities) { item in
                        mainViewModel.toCity = item
                        path.append(Path.ToStation)
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case Path.ToStation:
                    SelectionView(title: "Выбор станции",
                                  items: mainViewModel.toCity?.stations ?? []) { item in
                        mainViewModel.toStation = item
                        path = []
                    }
                                  .toolbar(.hidden, for: .tabBar)
                    
                case Path.Search:
                    if let fromCity = mainViewModel.fromCity,
                       let fromStation = mainViewModel.fromStation,
                       let toCity = mainViewModel.toCity,
                       let toStation = mainViewModel.toStation
                    {
                        CarriersView(title: "\(fromCity.name)" + " " + "(\(fromStation.name))" + " " + "→" + " " + "\(toCity.name)" + " " + "(\(toStation.name))", viewModel: carriersViewModel,
                                     onCarrierCardSelect: {
                            path.append(Path.CarrierInfo)
                        }) {
                            path.append(Path.Filters)
                        }
                        .toolbar(.hidden, for: .tabBar)
                    }
                    
                case Path.Filters:
                    FiltersView(viewModel: carriersViewModel)
                        .toolbar(.hidden, for: .tabBar)
                    
                case Path.CarrierInfo:
                    CarrierInfo(viewModel: carriersViewModel)
                        .toolbar(.hidden, for: .tabBar)
                case Path.UserAgreement:
                    UserAgreementView()
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    MainView()
}
