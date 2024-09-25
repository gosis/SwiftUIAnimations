//
//  ItemListView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    @State private var showList = false
        
    let previousSourceKey = String(describing: MainView.self)
    let sourceKey = String(describing: ItemListView.self)
    let nextSourceKey = String(describing: DetailView.self)
    
    @State var items = [
        "Test15",
        "Test14",
        "Test13",
        "Test12",
        "Test11",
        "Test10",
        "Test9",
        "Test8",
        "Test7",
        "Test6",
        "Test5",
        "Test4",
        "Test3",
        "Test2",
    ]
    
    var body: some View {
        ZStack {
            
            VStack {
                ScrollView {
                    ParalaxHeader {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "image", in: animation)
                            .frame(width: 200, height: 200)
                            .offset(y: 20)
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeOut(duration: AppConstants.logoAnimationDuration)) {
                                    animationCoordinator.removeState(sourceKey: previousSourceKey)
                                    globalState.navigation.popFromHomeNavigation()
                                }
                            }
                    }
                    .frame(height: 230)
                    .zIndex(0)
                    
                    if showList {
                        let stateHashable = animationCoordinator.getState(sourceKey: nextSourceKey)
                        let selectedItem = stateHashable as? String
                        ForEach(0..<items.count, id: \.self) { index in
                            let item = items[index]
                            
                            if selectedItem != item {
                                ItemListCell(item: item,
                                             selected: true,
                                             animation: animation)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: AppConstants.selectionAnimationDuration)) {
                                        animationCoordinator.addState(item: item, sourceKey: nextSourceKey)
                                        globalState.navigation.pushHomeNavigation(.detail(item))
                                    }
                                }
                                .frame(height: 60)
                            } else {
                                Spacer()
                                    .frame(height: UIScreen.main.bounds.height / 2)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.black)
            .onAppear {
                withAnimation(.easeIn) {
                    showList = true
                }
            }
        }
    }
}

#Preview {
    @Namespace var animation
    
    return ItemListView(animation: animation)
}
