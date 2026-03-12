import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        ZStack{
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                        .foregroundStyle(.white)
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(3)
                        .foregroundStyle(.white)
                }
            }
            .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
            
        }
        .background(.storiesBackground)
    }
}

#Preview {
    StoryView(story: MockDataProvider.storiesPacks[1].stories[0])
}
