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
        @State var globalState = GlobalState(navigation: .home([.main]))
        @State var animationCoordinator = AnimationCoordinator()
        
        WindowGroup {
            ContentView()
                .environmentObject(globalState)
                .environmentObject(animationCoordinator)
        }
    }
}
