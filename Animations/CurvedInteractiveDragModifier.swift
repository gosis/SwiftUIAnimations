import SwiftUI

struct CurvedInteractiveDragModifier: ViewModifier {
    var animationCoordinator: AnimationCoordinator
    var loginRouter: LoginRouter

    @State private var offsetX: CGFloat = 0
    @State private var dragY: CGFloat = 0 // Capture the Y position of the drag
    @State private var dragProgress: CGFloat = 0
    @State private var dragWidth: CGFloat = 0
    
    let sourceKey: String

    func body(content: Content) -> some View {
        content
            .clipShape(StrongCurveShape(dragOffset: offsetX, dragY: dragY))
            .offset(x: offsetX * 0.8)
            .gesture(dragGesture())
    }

    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 0 { // Only allow dragging from left to right
                    offsetX = value.translation.width
                    dragY = value.location.y // Capture the Y position of the drag
                    dragProgress = min(1.0, value.translation.width / UIScreen.main.bounds.width)
                    dragWidth = min(value.translation.width / 2, 100)
                }
            }
            .onEnded { value in
                // If the drag exceeds a threshold, complete the transition
                if value.translation.width > UIScreen.main.bounds.width * 0.3 {
                    withAnimation(.linear(duration: AppConstants.loginAnimationDuration)) {
                        offsetX = 0
                        dragY = 0
                        dragProgress = 0
                        animationCoordinator.removeState(sourceKey: sourceKey)
                        loginRouter.pop(LoginNavigation.self)
                    }
                } else {
                    // Reset the drag if the swipe wasn't far enough
                    withAnimation {
                        offsetX = 0
                        dragY = 0
                        dragProgress = 0
                    }
                }
            }
    }
}


struct StrongCurveShape: Shape {
    var dragOffset: CGFloat // The x-offset of the drag
    var dragY: CGFloat // Y position of the drag
    
    let safeAreaTop = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    let safeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(dragOffset, dragY) }
        set {
            dragOffset = newValue.first
            dragY = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Constrain the dragY to within the view bounds
        let curveCenterY = max(min(dragY, rect.height + safeAreaTop), safeAreaTop)

        // Define the control point positions for a smoother curve
        let controlPointX1 = dragOffset * 0.3 // Control point 1 for more dynamic transition
        let controlPointX2 = dragOffset * 0.3 // Control point 2 for more dynamic transition
        let controlPointYTop = -safeAreaTop
        let controlPointYBottom = rect.height + safeAreaBottom

        // Start at the top-left corner
        path.move(to: CGPoint(x: 0, y: -safeAreaTop))

        // Draw a straight line down the left side until just before the drag starts affecting the curve
        path.addLine(to: CGPoint(x: 0, y: controlPointYTop))

        // Add a cubic Bezier curve for a smoother transition
        path.addCurve(
            to: CGPoint(x: 0, y: controlPointYBottom), // End point of the curve (bottom of the view)
            control1: CGPoint(x: controlPointX1, y: curveCenterY), // First control point
            control2: CGPoint(x: controlPointX2, y: curveCenterY)  // Second control point
        )

        // Continue drawing the path down the left edge
        path.addLine(to: CGPoint(x: 0, y: rect.height + safeAreaBottom))

        // Complete the rectangle path by connecting the remaining sides
        path.addLine(to: CGPoint(x: rect.width, y: rect.height + safeAreaBottom)) // Bottom-right corner
        path.addLine(to: CGPoint(x: rect.width, y: -safeAreaTop)) // Top-right corner
        path.addLine(to: CGPoint(x: 0, y: -safeAreaTop)) // Back to the start

        return path
    }
}


