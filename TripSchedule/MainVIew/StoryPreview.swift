import SwiftUI

struct StoryPreview: View {
    let story: Story
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            
            Text(story.title)
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
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.ypBlue, lineWidth: 4)
        )
    }
}

#Preview {
    StoryPreview(story: MockDataProvider.storiesPacks[0].stories[0])
}
