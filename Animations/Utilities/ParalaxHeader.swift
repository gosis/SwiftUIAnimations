//
//  ParalaxHeader.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct ParalaxHeader<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            
            content()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(y: minY * -0.5)
        }
    }
}
