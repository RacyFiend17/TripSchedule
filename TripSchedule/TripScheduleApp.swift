import SwiftUI

@main
struct TripScheduleApp: App {
    @State private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
