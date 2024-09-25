//
//  ItemListCell.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimationsViewCell: View {
    let item: String
    let selected: Bool
    var animation: Namespace.ID
    

    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 150, height: 150)
                .matchedGeometryEffect(id: item, in: animation)
            /*Text(item)
                .font(.title)
                .frame(width: 150, height: 100)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .matchedGeometryEffect(id: "\(item)-text", in: animation)*/
    }
}
