import SwiftUI

struct TestingView: View {
    @Namespace private var animation
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            ZStack {
                if isExpanded {
                    expandedRectangle
                } else {
                    collapsedRectangle
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }
        }
    }
    
    var collapsedRectangle: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: "image", in: animation)
            .frame(maxWidth: 100, maxHeight: 100)
            .padding()
            .transition(.noTransition)
    }
    
    var expandedRectangle: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: "image", in: animation)
            .frame(maxWidth: 300, maxHeight: 300)
            .padding()
            .transition(.noTransition)
    }
}

#Preview {
    TestingView()
}
