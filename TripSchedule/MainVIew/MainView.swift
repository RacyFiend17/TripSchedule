import SwiftUI

struct MainView: View {
    @State private var selectedCity: City?
    @State private var selectedStation: Station?
    
    @State var viewModel = MainViewModel()
    
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
                                Text(viewModel.fromStation?.name ?? "Откуда")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(viewModel.fromStation?.name != nil ? Color(.black) : Color(.ypGray))
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
                                Text(viewModel.toStation?.name ?? "Куда")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(viewModel.toStation?.name != nil ? Color(.black) : Color(.ypGray))
                                    .padding(.leading, 16)
                                    .padding(.trailing, 13)
                                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(Color.white)
                            .navigationDestination(for: String.self) { value in
                                
                                switch value {
                                    
                                case "FromCity":
                                    SelectionView(title: "Выбор города",
                                                  items: MockDataProvider.cities) { item in
                                        viewModel.fromCity = item
                                        path.append("FromStation")
                                    }
                                    
                                case "FromStation":
                                    SelectionView(title: "Выбор станции",
                                                  items: viewModel.fromCity?.stations ?? []) { item in
                                        viewModel.fromStation = item
                                        path = []
                                    }
                                    
                                case "ToCity":
                                    SelectionView(title: "Выбор города",
                                                  items: MockDataProvider.cities) { item in
                                        viewModel.toCity = item
                                        path.append("ToStation")
                                    }
                                    
                                case "ToStation":
                                    SelectionView(title: "Выбор станции",
                                                  items: viewModel.toCity?.stations ?? []) { item in
                                        viewModel.toStation = item
                                        path = []
                                    }
                                    
                                default:
                                    EmptyView()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 128)
                        .cornerRadius(20)
                        .padding([.leading, .top, .bottom], 16)
                        
                        
                        Button() {
                            viewModel.swapDirections()
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
                    
                    if viewModel.isSearchEnabled{
                        Button() {
                            print("Поиск маршрута")
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
            }
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
