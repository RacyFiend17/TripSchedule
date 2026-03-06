import Foundation

struct Route: Identifiable, Hashable {
    let id = UUID()
    let carrierName: String
    let carrierLogoName: String
    let isTransfer: Bool
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let day: String
}

extension Route {
    var arrivalHour: Int? {
        extractHour(from: arrivalTime)
    }
    var departureHour: Int? {
        extractHour(from: departureTime)
    }
    
    private func extractHour(from time: String) -> Int? {
        let components = time.split(separator: ":")
        guard let hourString = components.first,
              let hour = Int(hourString) else {
            return nil
        }
        return hour
    }
}
