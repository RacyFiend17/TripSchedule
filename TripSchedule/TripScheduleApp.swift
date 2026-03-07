import SwiftUI

@main
struct TripScheduleApp: App {
    @State private var themeManager = ThemeManager()
    @State private var storiesManager = StoriesManager()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(storiesManager)
                .environment(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
