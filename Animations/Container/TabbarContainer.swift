import SwiftUI

struct TabbarContainer: View {
    @EnvironmentObject var router: Router
    
    @Namespace private var animation

    var body: some View {
        let needstohideTabBar = router.needsToHideTabbar()
        VStack(spacing: 0) {
            ZStack {
                ContainerView {
                    homeNavigationStack(animation: animation,
                                        homeNavigation: router.homeNavigation)
                }
                .opacity(router.selectedTab == .firstTab ? 1 : 0)
                .zIndex(router.selectedTab == .firstTab ? 1 : 0)
                ContainerView {
                    horizontalScrollNavigationStack(animation: animation, 
                                                    horizontalScrollNavigation: router.horizontalScrollNavigation)
                }
                .opacity(router.selectedTab == .secondTab ? 1 : 0)
                .zIndex(router.selectedTab == .secondTab ? 1 : 0)

                ContainerView {
                    tableNavigationStack(animation: animation, 
                                         tableNavigation: router.tableNavigation)
                }
                .opacity(router.selectedTab == .thirdTab ? 1 : 0)
                .zIndex(router.selectedTab == .thirdTab ? 1 : 0)
                
                ContainerView {
                    loadingListNavigationStack(animation: animation,
                                               loadingListNavigation: router.loadingListNavigation)
                }
                .opacity(router.selectedTab == .fourthTab ? 1 : 0)
                .zIndex(router.selectedTab == .fourthTab ? 1 : 0)
            }
            .background(.black)
            .padding(.bottom, needstohideTabBar ? -100 : 0)
            
            HStack {
                TabBarButton(tab: .firstTab, selectedTab: $router.selectedTab,
                             icon: "house")
                Spacer()
                TabBarButton(tab: .secondTab, selectedTab: $router.selectedTab,
                             icon: "magnifyingglass")
                Spacer()
                TabBarButton(tab: .thirdTab, selectedTab: $router.selectedTab,
                             icon: "person.fill")
                Spacer()
                TabBarButton(tab: .fourthTab, selectedTab: $router.selectedTab,
                             icon: "person.fill")
            }
            .padding()
            .background(.white)
            .offset(y: needstohideTabBar ? 100 : 0)
        }
        .background(.black)
    }
    
    func homeNavigationStack(animation: Namespace.ID,
                        homeNavigation: [HomeNavigation]) -> some View {
        ZStack {
            ForEach(homeNavigation, id: \.id) { navigation in
                switch navigation {
                    case .main:
                        MainView(animation: animation)
                        .zIndex(1)
                        .transition(.noTransition)
                    case .list:
                        ItemListView(animation: animation)
                        .zIndex(2)
                        .transition(.noTransition)
                    case .detail(let item):
                        DetailView(animation: animation, item: item)
                        .zIndex(3)
                        .transition(.noTransition)
                }
            }
        }
    }
    
    func horizontalScrollNavigationStack(animation: Namespace.ID,
                                         horizontalScrollNavigation: [HorizontalScrollNavigation]) -> some View {
        ZStack {
            ForEach(horizontalScrollNavigation, id: \.id) { navigation in
                switch navigation {
                    case .main:
                        HorizontalScrollerView(animation: animation)
                            .transition(.noTransition)
                            .zIndex(1)
                case .detail(let item):
                    HorizontalScrollerDetailView(animation: animation,
                                                 item: item)
                        .transition(.noTransition)
                        .zIndex(2)
                }
            }
        }
    }
    
    func tableNavigationStack(animation: Namespace.ID,
                             tableNavigation: [TableNavigation]) -> some View {
        ZStack {
            ForEach(tableNavigation, id: \.id) { navigation in
                switch navigation {
                    case .animatedImageListView:
                        AnimatedImageListView(animation: animation)
                    case .animatedImageListItemView(let item):
                        AnimatedImageListItemView(animation: animation,
                                                  item: item)
                            .transition(.noTransition)
                            .zIndex(1)
                    case .animatedImageListDetailView2(let item):
                        AnimatedImageListDetailView2(animation: animation,
                                                     item: item)
                            .transition(.noTransition)
                            .zIndex(2)
                case .animatedImageListDetailView3(let item):
                    AnimatedImageListDetailView3(animation: animation,
                                                 item: item)
                        .transition(.navigationTransition)
                        .zIndex(3)
                }
            }
        }
    }
    
    func loadingListNavigationStack(animation: Namespace.ID,
                             loadingListNavigation: [LoadingListNavigation]) -> some View {
        ZStack {
            ForEach(loadingListNavigation, id: \.id) { navigation in
                switch navigation {
                    case .main:
                        LoadingListView()
                }
            }
        }
    }
}

enum Tab {
    case firstTab
    case secondTab
    case thirdTab
    case fourthTab
}

struct TabBarButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let icon: String
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(selectedTab == tab ? .blue : .gray)
        }
    }
}

#Preview {
    let router = Router()
    let animationCoordinator = AnimationCoordinator()
    return TabbarContainer()
        .environmentObject(router)
        .environmentObject(animationCoordinator)
}
