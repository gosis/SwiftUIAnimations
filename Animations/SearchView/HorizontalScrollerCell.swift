//
//  ItemListCell.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct HorizontalScrollerCell: View {
    let item: String
    let selected: Bool
    var animation: Namespace.ID
    

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 250, height: 150)
                .matchedGeometryEffect(id: item, in: animation)
            Text(item)
                .font(.title)
                .matchedGeometryEffect(id: "\(item)-text", in: animation)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
