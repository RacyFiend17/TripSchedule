import Foundation

protocol SelectableItem: Identifiable, Hashable {
    var name: String { get }
    var id: UUID { get }
}
