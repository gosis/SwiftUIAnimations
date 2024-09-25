//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimatedImageListItemView: View {
    var animation: Namespace.ID
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.gray
                .matchedGeometryEffect(id: "\(item)_cell", in: animation)
            VStack {
                let sourceKey = String(describing: AnimatedImageListView.self)
                let nextSourceKey = String(describing: AnimatedImageListDetailView2.self)
                if animationCoordinator.isActive(sourceKey: sourceKey) {
                    CustomNavigationBar(title: "Detail View", onDismiss: {
                        withAnimation(.linear(duration: AppConstants.animatedImageListAnimDuration)) {
                            animationCoordinator.removeState(sourceKey: sourceKey)
                            globalState.navigation.popFromTableNavigation()
                        }
                       }, onNext: {
                           withAnimation(.linear(duration: AppConstants.animatedImageListAnimDuration)) {
                               let sourceKey = String(describing: AnimatedImageListDetailView2.self)
                               animationCoordinator.addState(item: item, sourceKey: sourceKey)
                               globalState.navigation.pushTableNavigation(.animatedImageListDetailView2(item))
                           }
                       })
                }
                
                if !animationCoordinator.isActive(sourceKey: nextSourceKey) {
                    Image("logo")
                        .resizable()
                        .matchedGeometryEffect(id: "\(item)_image", in: animation)
                        .frame(width: 200, height: 200)
                    Text(item)
                        .matchedGeometryEffect(id: "\(item)_text", in: animation)
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
        }
        .background(.clear)
    }
}


#Preview {
    @Namespace var animation
    return AnimatedImageListItemView(animation: animation,
                                       item: "test")
}
