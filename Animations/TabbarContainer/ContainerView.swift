//
//  ContainerView.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        ZStack {
            content()
        }
        .background(.clear)
    }
}
