import Foundation

struct CarrierData: Hashable, Identifiable {
    var id: String { code }
    let code: String
    let name: String
    let logoURL: String?
    let email: String?
    let phone: String?
    let website: String?
}
