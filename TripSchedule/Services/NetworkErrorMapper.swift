import Foundation

func mapNetworkError(_ error: Error) -> AppErrorType {

    if isNoInternetError(error) {
        return .noInternet
    }
    return .serverError
}

private func isNoInternetError(_ error: Error) -> Bool {
    let nsError = error as NSError

    if nsError.domain == NSURLErrorDomain {
        switch nsError.code {
        case NSURLErrorNotConnectedToInternet,
             NSURLErrorNetworkConnectionLost,
             NSURLErrorCannotConnectToHost,
             NSURLErrorCannotFindHost,
             NSURLErrorDNSLookupFailed:
            return true
        case NSURLErrorTimedOut:
            
            if let underlying = nsError.userInfo[NSUnderlyingErrorKey] as? NSError {
                return isNoInternetError(underlying)
            } else {
                return false
            }
        default:
            break
        }
    }

    if let underlying = nsError.userInfo[NSUnderlyingErrorKey] as? NSError {
        return isNoInternetError(underlying)
    }

    if let underlyingErrors = nsError.userInfo["NSUnderlyingErrors"] as? [NSError] {
        return underlyingErrors.contains { isNoInternetError($0) }
    }

    return false
}
