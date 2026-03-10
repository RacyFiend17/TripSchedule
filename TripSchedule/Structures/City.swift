import Foundation

struct City: SelectableItem {
    let id: String
    let name: String
    let stations: [Station]
}
