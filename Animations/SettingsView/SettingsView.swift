import SwiftUI

struct SettingsView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    @StateObject private var viewModel = SettingsViewModel()
    @State private var selectedItem: Int?
    @State private var showItems = false
    
    let sourceKey = String(describing: SettingsView.self)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                ParallaxCirclesView()
                    .opacity(0.1)
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                    .cornerRadius(40)
                    .clipped()
                    .padding()
                    .zIndex(1000)
            }
            .frame(height: 200)
            LazyVStack {
                ForEach(viewModel.items, id: \.self) { item in
                    let isSelected = selectedItem == item
                    
                    if let stateHashable = animationCoordinator.getState(sourceKey: sourceKey),
                        let editingItem = stateHashable as? Int, 
                        editingItem == item {
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height)
                    } else {
                        itemView(for: item,
                                 isSelected: isSelected,
                                 showItems: showItems,
                                 onEditTap: {
                            withAnimation(.easeOut(duration: AppConstants.settingsTransitionAnimDuration)) {
                                animationCoordinator.addState(item: item, sourceKey: sourceKey)
                                router.settingsNavigation.push(.detail(item))
                            }
                        })
                        .onTapGesture {
                            withAnimation(.easeOut(duration: AppConstants.settingsTransitionAnimDuration)) {
                                if isSelected {
                                    selectedItem = nil
                                } else {
                                    selectedItem = item
                                }
                            }
                        }
                        .onAppear {
                            if item == viewModel.items.last {
                                viewModel.loadNextItems()
                            }
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("")
                        .padding()
                }
            }
            .padding(.vertical)
        }
        .onChange(of: router.selectedTab) { newTab in
            showItems = newTab == .fourthTab
        }
    }
    
    @ViewBuilder
    private func itemView(for item: Int, 
                          isSelected: Bool,
                          showItems: Bool,
                          onEditTap: @escaping () -> Void) -> some View {
        ZStack {
            Color.white
                .matchedGeometryEffect(id: "\(item)_cell", in: animation)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
                .padding(.horizontal)
            VStack {
                Text("Item \(item)")
                    .font(.title)
                    .matchedGeometryEffect(id: "\(item)_text", in: animation)
                    .padding(.vertical, 10)
                
                if isSelected {
                    Image("1")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .matchedGeometryEffect(id: "\(item)_image", in: animation)
                        .frame(width: UIScreen.main.bounds.width - 60,
                               height: 300)
                        .clipped()
                        .padding()
                    ZStack {
                        Text("Edit")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .matchedGeometryEffect(id: "\(item)_button", in: animation)
                    .padding(.horizontal, 40)
                    .onTapGesture {
                        onEditTap()
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 5)
        .offsetAppearanceEffect(showItems: showItems)
    }
}

#Preview {
    @State var router = Router()
    @State var animationCoordinator = AnimationCoordinator()
    @Namespace var animation
    return SettingsView(animation: animation)
        .environmentObject(animationCoordinator)
        .environmentObject(router)
        .background(Color.red)
}
