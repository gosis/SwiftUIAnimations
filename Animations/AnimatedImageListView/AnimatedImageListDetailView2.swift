//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimatedImageListDetailView2: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                CustomNavigationBar(title: "Next detail view", onDismiss: {
                    withAnimation(.linear(duration: AppConstants.animatedImageListAnimDuration)) {
                        let sourceKey = String(describing: AnimatedImageListDetailView2.self)
                        animationCoordinator.removeState(sourceKey: sourceKey)
                        router.tableNavigation.pop()
                    }
                   }, onNext: {
                       withAnimation(.spring(duration: AppConstants.navigationAnimationDuration)) {
                           router.tableNavigation.push(.animatedImageListDetailView3(item))
                       }
                   })
                HStack {
                    Image("logo")
                        .resizable()
                        .matchedGeometryEffect(id: "\(item)_image", in: animation)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    Text(item)
                        .matchedGeometryEffect(id: "\(item)_text", in: animation)
                        .font(.body)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(20)
                .background(Color.red)
                Spacer()
            }
        }
        .background(.clear)
    }
}

#Preview {
    @Namespace var animation
    return AnimatedImageListDetailView2(animation: animation, item: "test")
}
