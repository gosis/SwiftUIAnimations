//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimationsDetailView: View {
    var animation: Namespace.ID
    @State var item: String
    var onDismiss: () -> Void
    
    @State private var showItems = false
    @State private var dismissing = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .ignoresSafeArea()
                .matchedGeometryEffect(id: item, in: animation)
            
            if (dismissing == false) {
                VStack {
                    if showItems {
                        CustomNavigationBar(title: "Detail View") {
                            dismissing = true
                            onDismiss()
                        }
                    }
                    Text(item)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        .background(.clear)
        .onAppear {
            dismissing = false
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.horizontalAnimation) {
                withAnimation(.easeIn) {
                    showItems = true
                }
            }
        }
    }
}

#Preview {
    @Namespace var animation
    
    return AnimationsDetailView(animation: animation,
                                item: "test") {
        
    }
}
