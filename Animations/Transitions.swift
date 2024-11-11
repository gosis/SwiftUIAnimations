//
//  TestTransition.swift
//  Animations
//
//  Created by Gints Osis on 03/09/2024.
//

import SwiftUI

extension AnyTransition {
    
    /// Custom transition used to remove default opacity transitions added by Apple
    /// Some animation has to happen otherwise a default transition is applied
    /// so as a workaround we use a 0.01 scale change
    static var noTransition: AnyTransition { get {
        AnyTransition.modifier(
            active: NoTransitionModifier(scale: 0.99),
            identity: NoTransitionModifier(scale: 1))
        }
    }
    
    static var navigationTransition: AnyTransition {
        AnyTransition.move(edge: .trailing)
            .combined(with: AnyTransition.modifier(
                active: ScaleAndBackgroundModifier(scale: 1.2, opacity: 0.0),
                identity: ScaleAndBackgroundModifier(scale: 1.0, opacity: 0.4)
            ))
    }
}

struct ScaleAndBackgroundModifier: ViewModifier {
    let scale: CGFloat
    let opacity: Double
    
    func body(content: Content) -> some View {
        ZStack {
            Color.black
                .opacity(opacity)
                .ignoresSafeArea()
            content
                .scaleEffect(scale)
        }
        .zIndex(1001)
    }
}

struct NoTransitionModifier: ViewModifier {
    let scale: Double
    
    func body(content: Content) -> some View {
        content.scaleEffect(scale)
    }
}
