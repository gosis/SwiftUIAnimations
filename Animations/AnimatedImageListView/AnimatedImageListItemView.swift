//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimatedImageListItemView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.gray
                .matchedGeometryEffect(id: "\(item)_cell", in: animation)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                let sourceKey = String(describing: AnimatedImageListView.self)
                let nextSourceKey = String(describing: AnimatedImageListDetailView2.self)
                if animationCoordinator.isActive(sourceKey: sourceKey) {
                    CustomNavigationBar(title: "Detail View", onDismiss: {
                        withAnimation(.linear(duration: AppConstants.animatedImageListAnimDuration)) {
                            animationCoordinator.removeState(sourceKey: sourceKey)
                            router.pop(TableNavigation.self)
                        }
                       }, onNext: {
                           withAnimation(.linear(duration: AppConstants.animatedImageListAnimDuration)) {
                               let sourceKey = String(describing: AnimatedImageListDetailView2.self)
                               animationCoordinator.addState(item: item, sourceKey: sourceKey)
                               router.push(TableNavigation.animatedImageListDetailView2(item))
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
    }
}


#Preview {
    @State var router = Router()
    @State var animationCoordinator = AnimationCoordinator()
    @Namespace var animation
    return AnimatedImageListItemView(animation: animation,
                                       item: "test")
        .environmentObject(router)
        .environmentObject(animationCoordinator)
}
