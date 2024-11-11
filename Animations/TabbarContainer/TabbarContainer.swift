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
                                        homeRouter: router.homeNavigation)
                }
                .opacity(router.selectedTab == .firstTab ? 1 : 0)
                .zIndex(router.selectedTab == .firstTab ? 1 : 0)
                ContainerView {
                    searchNavigationStack(animation: animation,
                                          searchRouter: router.searchNavigation)
                }
                .opacity(router.selectedTab == .secondTab ? 1 : 0)
                .zIndex(router.selectedTab == .secondTab ? 1 : 0)

                ContainerView {
                    notificationsNavigationStack(animation: animation,
                                                 notificationsRouter: router.notificationsNavigation)
                }
                .opacity(router.selectedTab == .thirdTab ? 1 : 0)
                .zIndex(router.selectedTab == .thirdTab ? 1 : 0)
                
                ContainerView {
                    settingsNavigationStack(animation: animation,
                                            settingsRouter: router.settingsNavigation)
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
                             icon: "bell.fill")
                Spacer()
                TabBarButton(tab: .fourthTab, selectedTab: $router.selectedTab,
                             icon: "gearshape.fill")
            }
            .padding()
            .padding(.bottom, UIApplication.shared.safeAreaInsets.bottom > 0 ? 0 : 30)
            .background(.white)
            .offset(y: needstohideTabBar ? 100 : 0)
        }
        .background(.black)
    }
    
    func homeNavigationStack(animation: Namespace.ID,
                        homeRouter: BaseRouter<HomeNavigation>) -> some View {
        ZStack {
            ForEach(homeRouter.navigationStacks, id: \.id) { navigation in
                switch navigation {
                    case .main:
                    HomeView(animation: animation)
                        .zIndex(1)
                        .transition(.noTransition)
                    case .list:
                    HomeTableView(animation: animation)
                        .zIndex(2)
                        .transition(.noTransition)
                    case .detail(let item):
                    HomeDetailView(animation: animation, item: item)
                        .zIndex(3)
                        .transition(.noTransition)
                }
            }
        }
    }
    
    func searchNavigationStack(animation: Namespace.ID,
                                         searchRouter: BaseRouter<SearchNavigation>) -> some View {
        ZStack {
            ForEach(searchRouter.navigationStacks, id: \.id) { navigation in
                switch navigation {
                    case .main:
                    SearchView(animation: animation)
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
    
    func notificationsNavigationStack(animation: Namespace.ID,
                              notificationsRouter: BaseRouter<NotificationsNavigation>) -> some View {
        ZStack {
            ForEach(notificationsRouter.navigationStacks, id: \.id) { navigation in
                switch navigation {
                case .notificationsView:
                        NotificationsView(animation: animation)
                case .notificationsDetailView(let item):
                    NotificationsDetailView(animation: animation,
                                                  item: item)
                            .transition(.noTransition)
                            .zIndex(1)
                case .notificationsDetailView2(let item):
                    NotificationsDetailView2(animation: animation,
                                                     item: item)
                            .transition(.noTransition)
                            .zIndex(2)
                case .notificationsDetailView3(let item):
                    NotificationsDetailView3(animation: animation,
                                                 item: item)
                        .transition(.navigationTransition)
                        .zIndex(3)
                }
            }
        }
    }
    
    func settingsNavigationStack(animation: Namespace.ID,
                             settingsRouter: BaseRouter<SettingsNavigation>) -> some View {
        ZStack {
            ForEach(settingsRouter.navigationStacks, id: \.id) { navigation in
                switch navigation {
                    case .main:
                    SettingsView(animation: animation)
                            .transition(.noTransition)
                            .zIndex(1)
                    case .detail(let item):
                    SettingsDetailView(animation: animation, 
                                              item: item)
                            .transition(.noTransition)
                            .zIndex(2)
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
