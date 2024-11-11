import SwiftUI

struct HomeDetailViewScroller: View {
    let images = ["1", "2", "3", "4", "5", "6"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                ForEach(images, id: \.self) { item in
                    GeometryReader { geometry in
                        Image(item)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .frame(height: 300)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    HomeDetailViewScroller()
}
