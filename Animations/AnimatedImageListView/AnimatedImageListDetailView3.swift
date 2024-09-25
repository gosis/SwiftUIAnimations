//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimatedImageListDetailView3: View {
    var animation: Namespace.ID
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                CustomNavigationBar(title: "Final detail view", onDismiss: {
                    withAnimation(.spring(duration: AppConstants.navigationAnimationDuration)) {
                        globalState.navigation.popFromTableNavigation()
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
    return AnimatedImageListDetailView3(animation: animation, item: "test")
}
