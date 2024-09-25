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
                        switch homeNavigation {
                        case .main:
                            MainView(animation: animation)
                        case .list:
                            ItemListView(animation: animation)
                        }
                    case .search:
                        LoadingListView()
                    case .profile:
                        AnimationsView(animation: animation)
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
    ContentView()
}
