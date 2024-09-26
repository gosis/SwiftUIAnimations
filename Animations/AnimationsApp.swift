//
//  AnimationsApp.swift
//  Animations
//
//  Created by Gints Osis on 29/08/2024.
//

import SwiftUI

@main
struct AnimationsApp: App {
    var body: some Scene {
        @State var router = Router()
        @State var animationCoordinator = AnimationCoordinator()
        
        WindowGroup {
            TabbarContainer()
                .environmentObject(animationCoordinator)
                .environmentObject(router)
        }
    }
}
