import SwiftUI

struct CarriersView: View {
    let title: String
    
    @State var viewModel: CarriersViewModel
    
    let onCarrierCardSelect: () -> Void
    let onFilterSelect: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.vertical, 16)
                
                ZStack {
                    
                    VStack {
                        Spacer()
                        Text("Вариантов нет")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.ypBlack)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(viewModel.filteredRoutes.isEmpty ? 1 : 0)
                    
                    // Список маршрутов (прозрачен, когда нет маршрутов)
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.filteredRoutes) { route in
                                Button {
                                    viewModel.selectedRoute = route
                                    onCarrierCardSelect()
                                    print("робит")
                                } label: {
                                    RouteCard(route: route)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                    .opacity(viewModel.filteredRoutes.isEmpty ? 0 : 1)
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(Color(.ypWhite))
            .navigationTitle("")
            .toolbarRole(.editor)
            
            VStack(spacing: 0) {
                Spacer()
                Button {
                    onFilterSelect()
                } label: {
                    HStack(spacing: 4) {
                        Text("Уточнить время")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color(.white))
                        
                        if viewModel.hasActiveFilter {
                            Circle()
                                .fill(Color.ypRed)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.ypBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding([.top, .horizontal], 16)
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

