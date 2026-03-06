final class MockDataProvider {
    
    static let cities: [City] = [
        City(
            name: "Москва",
            stations: [
                Station(name: "Киевский вокзал"),
                Station(name: "Курский вокзал"),
                Station(name: "Ярославский вокзал"),
                Station(name: "Белорусский вокзал"),
                Station(name: "Савеловский вокзал"),
                Station(name: "Ленинградский вокзал")
            ]
        ),
        City(
            name: "Санкт-Петербург",
            stations: [
                Station(name: "Балтийский вокзал"),
                Station(name: "Московский вокзал"),
                Station(name: "Финляндский вокзал")
            ]
        ),
        City(
            name: "Сочи",
            stations: [
                Station(name: "Сочи"),
                Station(name: "Адлер")
            ]
        )
    ]
    
    static let routes: [Route] = [
        Route(
            carrierName: "РЖД",
            carrierLogoName: "rzdLogo",
            isTransfer: true,
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            day: "14 января"
        ),
        Route(
            carrierName: "ФГК",
            carrierLogoName: "fgkLogo",
            isTransfer: false,
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            day: "15 января"
        ),
        Route(
            carrierName: "Урал логистика",
            carrierLogoName: "uralLogistikaLogo",
            isTransfer: false,
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            day: "16 января"
        ),
        Route(
            carrierName: "РЖД",
            carrierLogoName: "rzdLogo",
            isTransfer: true,
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            day: "17 января"
        ),
        Route(
            carrierName: "РЖД",
            carrierLogoName: "rzdLogo",
            isTransfer: false,
            departureTime: "10:30",
            arrivalTime: "14:30",
            duration: "4 часа",
            day: "18 января"
        )
    ]
}
