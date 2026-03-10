import SwiftUI

struct TabBarView: View {
    @State private var tabBarViewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $tabBarViewModel.selectedTab) {
            MainView()
            .tabItem {
               Image("scheduleTabBarItem")
                    .renderingMode(.template)
            }
            .tag(0)
            SettingsView()
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
