//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct MainView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    let sourceKey = String(describing: MainView.self)

    var body: some View {
        VStack {
            Spacer()
            if !animationCoordinator.isActive(sourceKey: sourceKey) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image", in: animation)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .padding()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: AppConstants.logoAnimationDuration)) {
                            router.push(HomeNavigation.list)
                            animationCoordinator.addState(item: "logo", sourceKey: sourceKey)
                        }
                    }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
