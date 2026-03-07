import Observation
import Foundation

@Observable final class StoriesManager {
    
    var watchedStoriePackNumbers: Set<Int> = [] {
        didSet {
            if oldValue != watchedStoriePackNumbers {
                saveToUserDefaults()
            }
        }
    }
    
    init() {
        loadFromUserDefaults()
    }
    
    private func saveToUserDefaults() {
        // Set автоматически конвертируется в Array при сохранении
        UserDefaults.standard.set(Array(watchedStoriePackNumbers), forKey: "watchedStoriePackNumbers")
    }
    
    private func loadFromUserDefaults() {
        if let array = UserDefaults.standard.array(forKey: "watchedStoriePackNumbers") as? [Int] {
            watchedStoriePackNumbers = Set(array)
        } else {
            watchedStoriePackNumbers = []
        }
    }
    
    func markAsWatched(packNumber: Int) {
        watchedStoriePackNumbers.insert(packNumber)
    }
    
    func isWatched(packNumber: Int) -> Bool {
        watchedStoriePackNumbers.contains(packNumber)
    }
    
    func clearAll() {
        watchedStoriePackNumbers.removeAll()
    }
}
