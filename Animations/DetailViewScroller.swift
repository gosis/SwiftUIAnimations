import SwiftUI

struct DetailViewScroller: View {
    let images = ["1", "2", "3", "4", "5", "6"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                ForEach(images, id: \.self) { item in
                    GeometryReader { geometry in
                        Image(item)
                            .resizable()
                            .scaledToFill()
                            .offset(y: calculateOffset(offset: geometry.frame(in: .global).minY))
                            .frame(width: geometry.size.width, height: 300)
                            .scaleEffect(calculateScaleEffect(offset: geometry.frame(in: .global).minY)) // Simulating the effect of `scrollTransition`
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)  // Optional: Shadow for visual depth
                    }
                    .frame(height: 300)
                }
            }
            .padding(.horizontal, 20) // Replace contentMargins with padding
        }
        .navigationTitle("Detail View Scroller") // Add navigation title for context
    }

    // Offset calculation to give parallax effect
    func calculateOffset(offset: CGFloat) -> CGFloat {
        return offset / 10
    }
    
    // Calculate scale effect to simulate `scrollTransition` for scaling
    func calculateScaleEffect(offset: CGFloat) -> CGFloat {
        let scale = 1 - (offset / 1000) // Adjust the denominator for a more/less pronounced effect
        return max(0.9, min(1, scale)) // Limit scale between 0.9 and 1
    }
}

#Preview {
    DetailViewScroller()
}
