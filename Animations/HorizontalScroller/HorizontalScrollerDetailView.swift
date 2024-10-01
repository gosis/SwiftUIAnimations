//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct HorizontalScrollerDetailView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    @State var item: String
    
    @State private var showItems = false
    @State private var dismissing = false
    
    let sourceKey = String(describing: HorizontalScrollerView.self)

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if (dismissing == false) {
                    if showItems {
                        CustomNavigationBar(title: "Detail View") {
                            dismissing = true
                            withAnimation {
                                animationCoordinator.removeState(sourceKey: sourceKey)
                                router.horizontalScrollNavigation.pop()
                            }
                        }
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: showItems ? 0 : 20)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: item, in: animation)
                        .frame(maxWidth: .infinity, maxHeight: showItems ? .infinity : 150)
                    Text(item)
                        .font(.title)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "\(item)-text", in: animation)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            dismissing = false
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.horizontalAnimation) {
                withAnimation(.easeOut(duration: AppConstants.horizontalFullscreenAnimation)) {
                    showItems = true
                }
            }
        }
    }
}

#Preview {
    @Namespace var animation
    
    return HorizontalScrollerDetailView(animation: animation,
                                item: "test")
}
