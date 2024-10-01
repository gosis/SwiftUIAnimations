import SwiftUI

struct AnimatedImageListView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    let items = Array(1...10).map { "Item \($0)" }
    @State private var selectedItem: String?
    @State private var showItems = false
    
    let string = String(describing: AnimatedImageListView.self)

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in    
                        AnimatedImageListCell(item: item,
                                              animation: animation)
                        .transition(.noTransition)
                        .scaleAppearanceEffect(showItems: showItems)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: AppConstants.animatedImageListAnimDuration)) {
                                let sourceKey = String(describing: AnimatedImageListView.self)
                                
                                animationCoordinator.addState(item: item,
                                                              sourceKey: sourceKey)
                                router.tableNavigation.push(.animatedImageListItemView(item))
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .onChange(of: router.selectedTab) { newTab in
            showItems = newTab == .thirdTab
        }
    }
}

#Preview {
    @Namespace var animation
    return AnimatedImageListView(animation: animation)
}

