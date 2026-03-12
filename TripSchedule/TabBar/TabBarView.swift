import SwiftUI

struct TabBarView: View {
    @State private var tabBarViewModel = TabBarViewModel()
    @State private var mainPath: [MainPath] = []
    @State private var settingsPath: [SettingsPath] = []
    
    var body: some View {
        TabView(selection: $tabBarViewModel.selectedTab) {
            NavigationStack(path: $mainPath) {
                MainView(path: $mainPath,
                         onError: { error in
                    mainPath.removeAll()
                    tabBarViewModel.selectedTab = 1
                    settingsPath.removeAll()

                    switch error {
                    case .serverError:
                        settingsPath.append(.serverError)

                    case .noInternet:
                        settingsPath.append(.noInternet)
                    }
                }
                )
            }
            .tabItem {
                Image("scheduleTabBarItem")
                    .renderingMode(.template)
            }
            .tag(0)
            
            NavigationStack(path: $settingsPath) {
                SettingsView(path: $settingsPath)
                
            }
            .tabItem {
                Image("optionsTabBarItem")
                    .renderingMode(.template)
            }
            .tag(1)
        }
        .onChange(of: tabBarViewModel.selectedTab) { oldValue, newValue in
            if newValue == 0 {
                settingsPath.removeAll()
                tabBarViewModel.isServerErrorShown = false
            }
        }
        .tint(.ypBlack)
    }
}

