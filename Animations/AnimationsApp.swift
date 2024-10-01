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
        @State var animationCoordinator = AnimationCoordinator()
        @State var router = Router()
                
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(animationCoordinator)
                .environmentObject(router)
        }
    }
}
