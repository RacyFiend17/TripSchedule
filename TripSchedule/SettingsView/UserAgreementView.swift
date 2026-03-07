import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer/ru/")!)
                .ignoresSafeArea(edges: [.leading, .bottom, .trailing])
                .overlay {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.ypBlack)
                        .imageScale(.large)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager())
}
