//
//  ViewModifiers.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

import SwiftUI

struct OffsetEffectModifier: ViewModifier {
    var showItems: Bool
    
    func body(content: Content) -> some View {
        content
            .animation(.snappy(), value: showItems)
            .offset(x: {
                if (!showItems) {
                    return Bool.random() ? 5 : -5
                }
                return 0
            }())
            .offset(y: {
                if (!showItems) {
                    return Bool.random() ? 5 : -5
                }
                return 0
            }())
    }
}

struct ScaleEffectModifier: ViewModifier {
    var showItems: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(showItems ? 1.0 : 0.95)
            .animation(.snappy(), value: showItems)
            .offset(x: {
                if (!showItems) {
                    return Bool.random() ? 3 : -3
                }
                return 0
            }())
    }
}
