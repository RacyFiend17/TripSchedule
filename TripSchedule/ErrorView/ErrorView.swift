import SwiftUI

struct ErrorView: View {
    let errorType: AppErrorType
    
    var body: some View {
        ZStack {
            Color.ypWhite
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(errorType.imageName)
                    .frame(width: 223, height: 223)
                
                Text(errorType.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.ypBlack)
            }
        }
    }
    
    
}

#Preview {
    ErrorView(errorType: AppErrorType.noInternet)
}
