import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ErrorView(errorType: AppErrorType.noInternet)
            .tabItem {
               Image("scheduleTabBarItem")
                    .renderingMode(.template)
            }
            .tag(0)
            ErrorView(errorType: AppErrorType.serverError)
            .tabItem {
                Image("optionsTabBarItem")
                    .renderingMode(.template)
            }
            .tag(1)
        }
        .tint(.ypBlack)
    }
}

#Preview {
    TabBarView()
}
