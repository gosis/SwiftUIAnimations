//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct NotificationsDetailView3: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                CustomNavigationBar(title: "Final detail view", onDismiss: {
                    withAnimation(.spring(duration: AppConstants.notificationsNavigationAnimDuration)) {
                        router.notificationsNavigation.pop()
                    }
                   })
                Spacer()
            }
        }
        .background(.clear)
    }
}

#Preview {
    @Namespace var animation
    return NotificationsDetailView3(animation: animation, item: "test")
}
