import Foundation

struct City: SelectableItem {
    let id = UUID()
    let name: String
    let stations: [Station]
}

