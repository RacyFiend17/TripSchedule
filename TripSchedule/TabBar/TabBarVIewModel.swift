import Observation

@Observable
@MainActor
final class TabBarViewModel {
    var selectedTab = 0
    var isServerErrorShown = false
}
