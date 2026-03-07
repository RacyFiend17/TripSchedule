import SwiftUI

struct SettingsView: View {
    @State private var isOn = false
    @Environment(ThemeManager.self) var themeManager
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        
        @Bindable var themeManager = themeManager
        
        NavigationStack {
            VStack(spacing: 16) {
                Toggle("Темная тема", isOn: Binding(
                    get: { themeManager.colorScheme == .dark },
                    set: { themeManager.colorScheme = $0 ? .dark : .light }
                ))
                .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
                .padding(.vertical, 14.5)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlack)
                
                NavigationLink {
                    UserAgreementView()
                        .toolbar(.hidden, for: .tabBar)
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle("")
                        .toolbarRole(.editor)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
