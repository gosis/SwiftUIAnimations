//
//  NavigationContainerView.swift
//  Animations
//
//  Created by Gints Osis on 01/10/2024.
//

import SwiftUI

struct NavigationContainerView: View {
    
    @Namespace private var animation
    @State private var isDetailViewActive = false
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .padding()
                
                Text("Home Screen")
                    .font(.largeTitle)
                    .padding()
                
                // Custom Button to trigger manual navigation
                Button("Go to Detail View") {
                    router.navigationTabPath.append("detail")
                }
                .padding()
                
                Button("Go to List View") {
                    router.navigationTabPath.append("list")
                }
                .padding()
            }
        }
    }
}

#Preview {
    let router = Router()
    return NavigationContainerView()
        .environmentObject(router)
}
