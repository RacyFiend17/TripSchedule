import SwiftUI

struct StoryPreview: View {
    let storyPack: StoryPack
    @Environment(StoriesManager.self) var storiesManager
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(storyPack.previewImageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            
            Text(storyPack.stories[0].title)
                .font(.system(size: 12, weight: .regular))
                .lineLimit(3)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .frame(width: 92, height: 140)
        .background(Color.storiesBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .opacity(storiesManager.isWatched(packNumber: storyPack.storyPackNumber) ? 1: 0.5)
        .overlay(storiesManager.isWatched(packNumber: storyPack.storyPackNumber) ?
                 RoundedRectangle(cornerRadius: 16)
            .stroke(Color.ypBlue, lineWidth: 4) :
                    nil
        )
    }
}
