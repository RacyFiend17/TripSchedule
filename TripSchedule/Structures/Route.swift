import Foundation

struct Route: Identifiable, Hashable {
    let id = UUID()
    let carrier: CarrierData
    let isTransfer: Bool
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let day: String
}

extension Route {

    init(segment: Components.Schemas.Segment) {
        let carrierAPI = segment.thread?.carrier
        
        self.carrier = CarrierData(
            code: String(carrierAPI?.code ?? 0),
            name: carrierAPI?.title ?? "Нет данных о названии перевозчика",
            logoURL: carrierAPI?.logo,
            email: (carrierAPI?.email != nil && carrierAPI?.email != "") ? carrierAPI?.email! : "Нет данных о почте",
            phone: (carrierAPI?.phone != nil && carrierAPI?.phone != "") ? carrierAPI?.phone! : "Нет данных о мобильном телефоне",
            website: carrierAPI?.url
        )
        
        self.isTransfer = false
        
        self.departureTime = Self.extractTime(segment.departure) ?? "—"
        self.arrivalTime = Self.extractTime(segment.arrival) ?? "—"
        self.day = Self.extractDay(segment.departure) ?? ""
        
        let hours = (segment.duration ?? 0) / 3600
        self.duration = Self.formatHours(hours)
    }
    
    var departureHour: Int? {
            let components = departureTime.split(separator: ":")
            guard let hourString = components.first,
                  let hour = Int(hourString) else { return nil }
            return hour
        }
}

private extension Route {

    static let inputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    static func extractTime(_ string: String?) -> String? {
        guard let string else { return nil }
        guard let time = string.split(separator: "T").last else { return nil }
        return String(time.prefix(5))
    }

    static func extractDay(_ string: String?) -> String? {
        guard let string else { return nil }
        guard let date = inputFormatter.date(from: string) else { return nil }
        return dayFormatter.string(from: date)
    }

    static func formatHours(_ hours: Int) -> String {
        let lastTwo = hours % 100
        let last = hours % 10
        
        switch (lastTwo, last) {
        case (11...14, _):
            return "\(hours) часов"
        case (_, 1):
            return "\(hours) час"
        case (_, 2...4):
            return "\(hours) часа"
        default:
            return "\(hours) часов"
        }
    }
}
