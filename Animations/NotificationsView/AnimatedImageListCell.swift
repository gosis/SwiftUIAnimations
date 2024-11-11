//
//  ItemListCell.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimatedImageListCell: View {
    let item: String
    var animation: Namespace.ID
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    

    var body: some View {
        ZStack {
            let sourceKey = String(describing: NotificationsView.self)
            if let stateHashable = animationCoordinator.getState(sourceKey: sourceKey),
                let selectedItem = stateHashable as? String,
                selectedItem == item {
                EmptyView()
            } else {
                Color.gray
                    .cornerRadius(10)
                    .matchedGeometryEffect(id: "\(item)_cell", in: animation)
                HStack {
                    Image("logo")
                        .resizable()
                        .matchedGeometryEffect(id: "\(item)_image", in: animation)
                        .frame(width: 100, height: 100)
                    Spacer()
                    Text(item)
                        .matchedGeometryEffect(id: "\(item)_text", in: animation)
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
        }
        .frame(height: 130)
    }
}

#Preview {
    @Namespace var animation
    return AnimatedImageListCell(item: "Testing",
                                 animation: animation)
}

