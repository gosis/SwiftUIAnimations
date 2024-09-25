import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let destination: AppNavigation
}

// The CustomTabBarView
struct CustomTabBarView: View {
    @EnvironmentObject var globalState: GlobalState

    // TabItems to iterate over
    let tabItems: [TabItem] = [
        TabItem(icon: "house.fill", title: "Home", destination: .home(.main)),
        TabItem(icon: "magnifyingglass", title: "Search", destination: .search),
        TabItem(icon: "person.fill", title: "Profile", destination: .profile),
        TabItem(icon: "list.dash", title: "Table", destination: .table([.animatedImageListView]))
    ]
    
    var body: some View {
        HStack {
            ForEach(tabItems) { tabItem in
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        globalState.navigation = tabItem.destination
                    }
                }) {
                    VStack {
                        Image(systemName: tabItem.icon)
                            .font(.system(size: 24))
                            .foregroundColor(globalState.navigation == tabItem.destination ? .blue : .gray)
                        Text(tabItem.title)
                            .font(.caption)
                            .foregroundColor(globalState.navigation == tabItem.destination ? .blue : .gray)
                    }
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: -5)
    }
}

#Preview {
    CustomTabBarView()
}
