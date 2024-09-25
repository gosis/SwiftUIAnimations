//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct MainView: View {
    var animation: Namespace.ID
    @EnvironmentObject var globalState: GlobalState

    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image", in: animation)
                .frame(maxWidth: 100, maxHeight: 100)
                .padding()
                .onTapGesture {
                    withAnimation(.easeOut(duration: AppConstants.logoAnimationDuration)) {
                        globalState.navigation = .home(.list)
                    }
                }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
