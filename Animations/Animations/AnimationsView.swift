//
//  ItemListView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct AnimationsView: View {
    
    var animation: Namespace.ID
    
    @State private var showItems = false
        
    let items = Array(1...10).map { "Item \($0)" }
    @State private var selectedItem: String?
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(items.indices, id: \.self) { index in
                        
                        let item = items[index]
                        let isSelected = selectedItem == item
                        if (isSelected) {
                            Spacer()
                                .frame(width: 150)
                        } else {
                            AnimationsViewCell(item: item,
                                               selected: isSelected,
                                               animation: animation)
                            .scaleEffect(showItems ? 1 : 0.3)
                            .animation(.spring().delay(Double(index) * 0.1), value: showItems)
                            .offset(x: selectedItem != nil && !isSelected ? (index < items.firstIndex(of: selectedItem!)! ? -UIScreen.main.bounds.width - 150 : UIScreen.main.bounds.width - 150) : 0)
                            .onTapGesture {
                                withAnimation(.easeOut(duration: AppConstants.horizontalAnimation)) {
                                    selectedItem = item
                                }
                            }
                        }
                    }
                    .frame(height: 150)
                }
                .padding()
            }
            .onAppear {
                showItems = true
            }
            
            if let selectedItem = selectedItem {
                AnimationsDetailView(animation: animation,
                                     item: selectedItem) {
                    withAnimation(.easeOut(duration: AppConstants.horizontalAnimation)) {
                        self.selectedItem = nil
                    }
                }
                                     .frame(width: UIScreen.main.bounds.width, height: 150)
                                     .transition(.noTransition)
            }
        }
        Spacer()
    }
}

#Preview {
    @Namespace var animation
    
    return AnimationsView(animation: animation)
}
