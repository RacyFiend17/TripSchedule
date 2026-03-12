import SwiftUI

struct CarrierInfo: View {
    @State private var viewModel: CarriersViewModel
    
    init(viewModel: CarriersViewModel) {
            _viewModel = State(initialValue: viewModel)
        }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(viewModel.selectedRoute?.carrier.imageName ?? "icon_name")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 104)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("\(viewModel.selectedRoute?.carrier.name ?? "Нет данных о названии перевозчика")")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(.ypBlack))
                    .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color(.ypBlack))
                    Text("\(viewModel.selectedRoute?.carrier.email ?? "Нет данных о почте")")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(.ypBlue))
                }
                .padding(.vertical, 12)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color(.ypBlack))
                    Text("\(viewModel.selectedRoute?.carrier.phoneNumber ?? "Нет данных о мобильном телефоне")")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(.ypBlue))
                }
                .padding(.vertical, 12)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
        .background(Color(.ypWhite))
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}
