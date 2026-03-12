import Foundation

struct Story: Hashable{
    let title: String
    let description: String
    let imageName: String

}

struct StoryPack: Hashable, Identifiable {
    let id = UUID()
    let stories: [Story]
    let previewImageName: String
    let storyPackNumber: Int
}
