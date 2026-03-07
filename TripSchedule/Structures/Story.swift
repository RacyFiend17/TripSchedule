import Foundation

struct Story: Hashable{
    let title: String
    let description: String
    let imageName: String
}

struct StoryPack: Hashable {
    let stories: [Story]
    let previewImageName: String
}
