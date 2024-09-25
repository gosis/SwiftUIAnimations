//
//  ItemListView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct HorizontalScroller: View {
    
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    
    @State private var showItems = false
    let items:[String]
    let sourceKey = String(describing: HorizontalScrollerView.self)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                let stateHashable = animationCoordinator.getState(sourceKey: sourceKey)
                let selectedItem = stateHashable as? String
                
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    let isSelected = selectedItem == item
                    if (isSelected) {
                        Spacer()
                            .frame(width: 250, height: 150)
                    } else {
                        HorizontalScrollerCell(item: item,
                                               selected: isSelected,
                                               animation: animation)
                        .scaleEffect(showItems ? 1 : 0.3)
                        .animation(.spring().delay(Double(index) * 0.1), value: showItems)
                        .offset(x: {
                            if let selectedItem = selectedItem, !isSelected {
                                // If selectedItem is not nil and this item is not selected, apply offset logic
                                if let selectedIndex = items.firstIndex(of: selectedItem) {
                                    return index < selectedIndex ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width
                                }
                            }
                            // Default case when selectedItem is nil or item is selected
                            return 0
                        }())
                        .onTapGesture {
                            withAnimation(.easeOut(duration: AppConstants.horizontalAnimation)) {
                                animationCoordinator.addState(item: item, sourceKey: sourceKey)
                                globalState.navigation.pushHorizontalScrollerNavigation(.detail(item))
                            }
                        }
                    }
                }
                .frame(height: 150)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
        }
        .onAppear {
            showItems = true
        }
    }
}

#Preview {
    @Namespace var animation
    
    @State var globalState = GlobalState(navigation: .home([.main]))
    @State var animationCoordinator = AnimationCoordinator()
    
    let items = Array(1...10).map { "Item \($0)" }
    return HorizontalScroller(animation: animation,
                              items: items)
        .environmentObject(globalState)
        .environmentObject(animationCoordinator)
}
