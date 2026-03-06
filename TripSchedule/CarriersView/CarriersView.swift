import SwiftUI

struct CarriersView: View {
    let title: String
    
    @State var viewModel: CarriersViewModel
    
    let onSelect: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.vertical, 16)
                
                if viewModel.filteredRoutes.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("Вариантов нет")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.ypBlack)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.filteredRoutes) { route in
                                RouteCard(route: route)
                            }
                        }
                    }
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
                    onSelect()
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
                    .cornerRadius(16)
                    .padding([.top, .horizontal], 16)
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

