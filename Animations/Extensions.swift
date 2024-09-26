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
}
