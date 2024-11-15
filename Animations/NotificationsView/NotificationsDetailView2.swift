//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct NotificationsDetailView2: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                CustomNavigationBar(title: "Next detail view", onDismiss: {
                    withAnimation(.linear(duration: AppConstants.notificationsAnimDuration)) {
                        let sourceKey = String(describing: NotificationsDetailView2.self)
                        animationCoordinator.removeState(sourceKey: sourceKey)
                        router.notificationsNavigation.pop()
                    }
                   }, onNext: {
                       withAnimation(.spring(duration: AppConstants.notificationsNavigationAnimDuration)) {
                           router.notificationsNavigation.push(.notificationsDetailView3(item))
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
    return NotificationsDetailView2(animation: animation, item: "test")
}
