import Foundation

struct CarrierData: Hashable, Identifiable {
    var id = UUID()
    
    let name: String
    let logoName: String
    let imageName: String
    let email: String
    let phoneNumber: String
}
