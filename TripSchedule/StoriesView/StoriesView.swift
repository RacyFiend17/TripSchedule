import SwiftUI
import Combine

struct StoriesView: View {
    
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.05
        ) {
            self.timerTickInternal = timerTickInternal
            self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        }
    }
    
    private let storiesPack: StoryPack
    private let configuration: Configuration
    private var currentStory: Story { storiesPack.stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(storiesPack.stories.count)) }
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @State private var dragOffset: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    @Environment(StoriesManager.self) var storiesManager
    
    init(storiesPack: StoryPack) {
        self.storiesPack = storiesPack
        configuration = Configuration(storiesCount: storiesPack.stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                StoryView(story: currentStory)
                    .offset(x: dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.width
                            }
                            .onEnded { value in
                                if value.translation.width < -50 {
                                    nextStory()
                                } else if value.translation.width > 50 {
                                    previousStory()
                                }
                                withAnimation {
                                    dragOffset = 0
                                }
                            }
                    )
                
                HStack(spacing: 0) {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            previousStory()
                            resetTimer()
                        }
                        .frame(width: geometry.size.width * 0.2)
                    
                    Color.clear
                        .frame(width: geometry.size.width * 0.6)

                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            nextStory()
                            resetTimer()
                        }
                        .frame(width: geometry.size.width * 0.2)
                }
                
                ProgressBar(numberOfSections: storiesPack.stories.count, progress: progress)
                    .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                CloseButton(action: {
                    if currentStoryIndex == storiesPack.stories.count - 1 {
                        storiesManager.markAsWatched(packNumber: storiesPack.storyPackNumber)
                    }
                    dismiss()
                })
                .padding(.top, 57)
                .padding(.trailing, 12)
            }
            .background(Color(.storiesBackground))
            .onAppear {
                timer = Self.createTimer(configuration: configuration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        progress = nextProgress
    }
    
    private func nextStory() {
        let storiesCount = storiesPack.stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : currentStoryIndex
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func previousStory() {
        let storiesCount = storiesPack.stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let previousStoryIndex = currentStoryIndex - 1 > 0 ? currentStoryIndex - 1 : 0
        withAnimation {
            progress = CGFloat(previousStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
        
}
