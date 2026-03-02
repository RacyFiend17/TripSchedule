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
}
