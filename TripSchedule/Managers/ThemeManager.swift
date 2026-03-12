import Observation
import SwiftUI

@Observable final class ThemeManager {

    var colorScheme: ColorScheme = .light {
        didSet {
            UserDefaults.standard.set(colorScheme == .dark ? "dark" : "light", forKey: "appTheme")
        }
    }
    
    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "appTheme")
        colorScheme = savedTheme == "dark" ? .dark : .light
    }
}

