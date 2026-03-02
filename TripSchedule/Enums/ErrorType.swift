enum AppErrorType: String {
    case noInternet
    case serverError
}

extension AppErrorType {
    
    var imageName: String {
        switch self {
        case .noInternet:
            return "noInternet"
        case .serverError:
            return "serverError"
        }
    }
    
    var title: String {
        switch self {
        case .noInternet:
            return "Нет интернета"
        case .serverError:
            return "Ошибка сервера"
        }
    }
}
