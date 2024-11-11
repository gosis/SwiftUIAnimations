//
//  HomeDetailView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct HomeDetailView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    @State var item: String
    
    @State private var showItems = false
    
    let sourceKey = String(describing: HomeDetailView.self)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .matchedGeometryEffect(id: item, in: animation)
                .transition(.scale)
                .frame(maxWidth: UIScreen.main.bounds.width, 
                       maxHeight: .infinity)
                .ignoresSafeArea()
        
                VStack {
                    if showItems {
                        CustomNavigationBar(title: "Detail View") {
                            withAnimation(.linear(duration: AppConstants.homeViewAnimDuration)) {
                                animationCoordinator.removeState(sourceKey: sourceKey)
                                showItems = false
                                router.homeNavigation.pop()
                            }
                        }
                    }
                    Text(item)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "\(item)-text", in: animation)
                    Spacer()
                    if (showItems && animationCoordinator.isActive(sourceKey: sourceKey)) {
                        HomeDetailViewScroller()
                    }
                }
        }
        .background(.clear)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.homeViewAnimDuration) {
                withAnimation(.easeIn) {
                    showItems = true
                }
            }
        }
    }
}
