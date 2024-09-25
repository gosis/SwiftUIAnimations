import SwiftUI

let duration = 0.25

struct ContentView: View {
    @Namespace private var animation
    @State private var showDetail = false
    
    @EnvironmentObject var globalState: GlobalState
    var body: some View {
        ZStack {
            VStack {
                switch globalState.navigation {
                    case .home(let homeNavigation):
                        homeNavigationStack(animation: animation,
                                            homeNavigation: homeNavigation)
                    case .search:
                        LoadingListView()
                    case .horizontalScroll(let horizontalScrollNavigation):
                        horizontalScrollNavigationStack(animation: animation,
                                                        horizontalScrollNavigation: horizontalScrollNavigation)
                    case .table(let tableNavigation):
                        tableNavigationStack(animation: animation,
                                            tableNavigation: tableNavigation)
                }
                CustomTabBarView()
            }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(globalState)
    }
    
    func homeNavigationStack(animation: Namespace.ID,
                        homeNavigation: [HomeNavigation]) -> some View {
        ZStack {
            ForEach(homeNavigation, id: \.id) { navigation in
                switch navigation {
                    case .main:
                        MainView(animation: animation)
                        .transition(.noTransition)
                        .zIndex(1)
                    case .list:
                        ItemListView(animation: animation)
                        .transition(.noTransition)
                        .zIndex(2)
                    case .detail(let item):
                        DetailView(animation: animation, item: item)
                        .transition(.noTransition)
                        .zIndex(3)
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
}

#Preview {
    @State var globalState = GlobalState(navigation: .home([.main]))
    @State var animationCoordinator = AnimationCoordinator()
    return ContentView()
        .environmentObject(globalState)
        .environmentObject(animationCoordinator)
}
