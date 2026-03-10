import Observation
import Foundation

@Observable
@MainActor
final class SelectionViewModel<Item: SelectableItem> {
    
    var items: [Item] = []
    var searchText: String = ""
    var error: Error?
    var isLoading: Bool = false
    let onServerError: () -> Void
    
    private let fetchItems: @Sendable () async throws -> [Item]
    
    var filteredItems: [Item] {
        searchText.isEmpty ? items : items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    init(fetchItems: @escaping @Sendable () async throws -> [Item], onServerError: @escaping () -> Void) {
        self.fetchItems = fetchItems
        self.onServerError = onServerError
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await fetchItems()
            self.items = result
        } catch {
            self.error = error
            onServerError()
        }
    }
}
