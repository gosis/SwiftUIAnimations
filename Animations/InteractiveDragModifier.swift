import SwiftUI

struct InteractiveDragModifier: ViewModifier {
    var animationCoordinator: AnimationCoordinator
    var loginRouter: LoginRouter

    @State private var offsetX: CGFloat = 0
    @State private var dragProgress: CGFloat = 0
    
    let sourceKey: String

    func body(content: Content) -> some View {
        content
            .offset(x: offsetX)
            .gesture(dragGesture())
    }

    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 0 { // Only allow dragging from left to right
                    offsetX = value.translation.width
                    dragProgress = min(1.0, value.translation.width / UIScreen.main.bounds.width)
                }
            }
            .onEnded { value in
                // If the drag exceeds a threshold, complete the transition
                if value.translation.width > UIScreen.main.bounds.width * 0.3 {
                    withAnimation(.linear(duration: AppConstants.loginAnimationDuration)) {
                        print(sourceKey)
                        offsetX = 0
                        dragProgress = 0
                        animationCoordinator.removeState(sourceKey: sourceKey)
                        loginRouter.pop(LoginNavigation.self)
                    }
                } else {
                    // Reset the drag if the swipe wasn't far enough
                    withAnimation {
                        offsetX = 0
                        dragProgress = 0
                    }
                }
            }
    }
}
