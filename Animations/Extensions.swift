//
//  Extensions.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
    
    func offsetAppearanceEffect(showItems: Bool) -> some View {
        self.modifier(OffsetEffectModifier(showItems: showItems))
    }
    
    func scaleAppearanceEffect(showItems: Bool) -> some View {
        self.modifier(ScaleEffectModifier(showItems: showItems))
    }
}

extension UIApplication {
    var safeAreaInsets: UIEdgeInsets {
        guard let windowScene = connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return .zero
        }
        return window.safeAreaInsets
    }
}
