import SwiftUI

struct AnimatedImageListView: View {
    var animation: Namespace.ID
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    let items = Array(1...10).map { "Item \($0)" }
    @State private var selectedItem: String?
    
    let string = String(describing: AnimatedImageListView.self)

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in    
                        AnimatedImageListCell(item: item,
                                              animation: animation)
                        .transition(.noTransition)
                            .onTapGesture {
                                withAnimation(.easeOut(duration: AppConstants.animatedImageListAnimDuration)) {
                                    let navigation = TableNavigation.animatedImageListItemView(item)
                                    let sourceKey = String(describing: AnimatedImageListView.self)
                                    
                                    animationCoordinator.addState(item: item, sourceKey: sourceKey)
                                    globalState.navigation.pushTableNavigation(navigation)
                                }
                            }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    @Namespace var animation
    return AnimatedImageListView(animation: animation)
}

