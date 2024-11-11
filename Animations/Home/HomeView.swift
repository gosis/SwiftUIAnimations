//
//  HomeView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

/// View with a single logo that opens into a tableview with the same logo as header when tapped
struct HomeView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    let sourceKey = String(describing: HomeView.self)

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
                        withAnimation(.easeOut(duration: AppConstants.homeViewAnimDuration)) {
                            router.homeNavigation.push(.list)
                            animationCoordinator.addState(item: "logo", sourceKey: sourceKey)
                        }
                    }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
