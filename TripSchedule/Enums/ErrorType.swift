enum AppErrorType: String {
    case noInternet
    case serverError
}

extension AppErrorType {
    
    var imageName: String {
        switch self {
        case .noInternet:
            "noInternet"
        case .serverError:
            "serverError"
        }
    }
    
    var title: String {
        switch self {
        case .noInternet:
            "Нет интернета"
        case .serverError:
            "Ошибка сервера"
        }
    }
}
