import SwiftUI

struct NotificationsView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    let items = Array(1...10).map { "Item \($0)" }
    @State private var selectedItem: String?
    @State private var showItems = false
    
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
                            withAnimation(.easeOut(duration: AppConstants.notificationsAnimDuration)) {
                                let sourceKey = String(describing: NotificationsView.self)
                                
                                animationCoordinator.addState(item: item,
                                                              sourceKey: sourceKey)
                                router.notificationsNavigation.push(.notificationsDetailView(item))
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
    return NotificationsView(animation: animation)
}

