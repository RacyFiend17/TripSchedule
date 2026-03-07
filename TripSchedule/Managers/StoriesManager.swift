//import Observation
//import Foundation
//
//@Observable final class StoriesManager {
//    
//    var watchedStoriePackNumbers: Set<Int> = [] {
//        didSet {
//            UserDefaults.standard.set(watchedStoriePackNumbers, forKey: "watchedStoriePackNumbers")
//        }
//    }
//    
//    init() {
//        guard let watchedStoriePackNumbers = UserDefaults.standard.array(forKey: "watchedStoriePackNumbers") as? [Int] else {
//            UserDefaults.standard.set([], forKey: "watchedStoriePackNumbers")
//            self.watchedStoriePackNumbers = []
//            return
//        }
//        self.watchedStoriePackNumbers = Set(watchedStoriePackNumbers)
//    }
//}
