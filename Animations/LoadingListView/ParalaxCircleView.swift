import SwiftUI

struct ParallaxCirclesView: View {
    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let size = geometry.size.width // The width and height of the square
            let offset: CGFloat = 100 // The offset from each edge's center

            ZStack {
                // Top Half Circle (offset downward)
                ParallaxHalfCircle(index: 0, minY: minY, size: size)
                    .rotationEffect(.degrees(0))
                    .position(x: size / 2, y: offset) // Offset downward by 30 points
                
                // Right Half Circle (offset leftward)
                ParallaxHalfCircle(index: 1, minY: minY, size: size)
                    .rotationEffect(.degrees(90))
                    .position(x: size - offset, y: size / 2) // Offset leftward by 30 points
                
                // Bottom Half Circle (offset upward)
                ParallaxHalfCircle(index: 2, minY: minY, size: size)
                    .rotationEffect(.degrees(180))
                    .position(x: size / 2, y: size - offset) // Offset upward by 30 points
                
                // Left Half Circle (offset rightward)
                ParallaxHalfCircle(index: 3, minY: minY, size: size)
                    .rotationEffect(.degrees(270))
                    .position(x: offset, y: size / 2) // Offset rightward by 30 points
            }
            .frame(width: size, height: size)
        }
        .frame(height: UIScreen.main.bounds.width) // Set the square height equal to its width
    }
}

struct ParallaxHalfCircle: View {
    var index: Int
    var minY: CGFloat
    var size: CGFloat
    
    var body: some View {
        let offset = minY * CGFloat(0.1 + Double(index) * 0.1)
        
        return Circle()
            .fill(getColor(index: index))
            .frame(width: size, height: size) // Set circle size equal to the square's width
            .offset(y: offset)
    }
    
    func getColor(index: Int) -> Color {
        let colors: [Color] = [.blue, .blue.opacity(0.8), .cyan, .green, .blue]
        return colors[index % colors.count]
    }
}

#Preview {
    ParallaxCirclesView()
}
