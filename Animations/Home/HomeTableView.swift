//
//  HomeTableView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

/// TableView with header opening each item with transition
/// of cell title and moving lower cells out of the screen to the bottom
struct HomeTableView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    @State private var showList = false
        
    let previousSourceKey = String(describing: HomeView.self)
    let sourceKey = String(describing: HomeTableView.self)
    let nextSourceKey = String(describing: HomeDetailView.self)
    
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
                                withAnimation(.easeOut(duration: AppConstants.homeViewAnimDuration)) {
                                    animationCoordinator.removeState(sourceKey: previousSourceKey)
                                    router.homeNavigation.pop()
                                }
                            }
                    }
                    .frame(height: 230)
                    .zIndex(0)
                    
                    if showList && animationCoordinator.isActive(sourceKey: previousSourceKey) {
                        let stateHashable = animationCoordinator.getState(sourceKey: nextSourceKey)
                        let selectedItem = stateHashable as? String
                        ForEach(0..<items.count, id: \.self) { index in
                            let item = items[index]
                            
                            if selectedItem != item {
                                HomeTableViewCell(item: item,
                                             selected: true,
                                             animation: animation)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: AppConstants.homeViewAnimDuration)) {
                                        animationCoordinator.addState(item: item, sourceKey: nextSourceKey)
                                        router.homeNavigation.push(.detail(item))
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
