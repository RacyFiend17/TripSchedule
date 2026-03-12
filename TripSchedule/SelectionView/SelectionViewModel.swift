import Observation
import Foundation

@Observable
@MainActor
final class SelectionViewModel<Item: SelectableItem> {
    
    var items: [Item] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var isViewDisappeared: Bool = false
    
    let onError: (AppErrorType) -> Void
    
    private let fetchItems: @Sendable () async throws -> [Item]
    
    var filteredItems: [Item] {
        searchText.isEmpty ? items : items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    init(fetchItems: @escaping @Sendable () async throws -> [Item], onError: @escaping (AppErrorType) -> Void) {
        self.fetchItems = fetchItems
        self.onError = onError
    }
    
    func loadItems() async {
        isLoading = true
        
        do {
            try Task.checkCancellation()
            
            let result = try await fetchItems()
            
            try Task.checkCancellation()
            
            await MainActor.run {
                self.items = result
                self.isLoading = false
            }
        } catch {
            
            if Task.isCancelled {
                return
            }

            await MainActor.run {
                self.isLoading = false
                self.onError(mapNetworkError(error))
            }
        }
    }
    
    func setViewDisappeared(_ disappeared: Bool) {
        isViewDisappeared = disappeared
    }
}
