import SwiftUI

struct ErrorView: View {
    @State var viewModel: ErrorViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(viewModel.imageName)
                    .frame(width: 223, height: 223)
                
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.ypBlack)
            }
        }
    }
}

#Preview {
    ErrorView(viewModel: ErrorViewModel(errorType: .noInternet))
}
