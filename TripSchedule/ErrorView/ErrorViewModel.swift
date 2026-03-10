import SwiftUI

@Observable final class ErrorViewModel {
    let imageName: String
    let title: String
    
    init(errorType: AppErrorType) {
        self.imageName = errorType.imageName
        self.title = errorType.title
    }
}
