import SwiftUI

struct SettingsView: View {
    @State private var isOn = false
    @Environment(ThemeManager.self) var themeManager
    @Environment(\.colorScheme) var systemColorScheme
    @Binding var path: [SettingsPath]
    
    var body: some View {
        
        @Bindable var themeManager = themeManager
        
        VStack(spacing: 16) {
            Toggle("Темная тема", isOn: Binding(
                get: { themeManager.colorScheme == .dark },
                set: { themeManager.colorScheme = $0 ? .dark : .light }
            ))
            .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
            .padding(.vertical, 14.5)
            .font(.system(size: 17, weight: .regular))
            .foregroundStyle(.ypBlack)
            
            
            Button {
                path.append(SettingsPath.userAgreement)
            } label: {
                HStack{
                    Text("Пользовательское соглашение")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.ypBlack)
                        .imageScale(.large)
                }
            }
            .padding(.vertical, 18)
            
            Spacer()
            
            VStack (alignment: .center, spacing: 16){
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlack)
                Text("Версия 3.0")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlack)
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(.ypWhite)
        .navigationDestination(for: SettingsPath.self) { value in
            switch value {
            case .serverError:
                let errorViewModel = ErrorViewModel(errorType: .serverError)
                ErrorView(viewModel: errorViewModel)
                    .navigationBarBackButtonHidden(true)
            case .noInternet:
                let errorViewModel = ErrorViewModel(errorType: .noInternet)
                ErrorView(viewModel: errorViewModel)
                    .navigationBarBackButtonHidden(true)
            case .userAgreement:
                UserAgreementView()
                    .toolbar(.hidden, for: .tabBar)
                    .navigationBarBackButtonHidden(true)
                    .navigationTitle("")
                    .toolbarRole(.editor)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
