//
//  HomeTableViewCell.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

/// Cell in HomeTableView
/// with animateable title and background
struct HomeTableViewCell: View {
    let item: String
    let selected: Bool
    var animation: Namespace.ID
    

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .matchedGeometryEffect(id: item, in: animation)
                .transition(.scale)
            Text(item)
                .font(.largeTitle)
                .foregroundColor(.white)
                .matchedGeometryEffect(id: "\(item)-text", in: animation)

        }
    }
}
