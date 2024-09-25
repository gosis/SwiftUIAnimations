//
//  ItemListView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct HorizontalScrollerView: View {
    
    @EnvironmentObject var globalState: GlobalState
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    
    @State private var showItems = false
            
    let sourceKey = String(describing: HorizontalScrollerView.self)
    
    var body: some View {
        ZStack {
            VStack {
                scrollerTitle("First scroller title")
                HorizontalScroller(animation: animation, items: Array(1...10).map { "Item \($0)" })
                Spacer()
                    .frame(height: 20)
                scrollerTitle("First scroller title")
                HorizontalScroller(animation: animation, items: Array(11...20).map { "Item \($0)" })
                Spacer()
                    .frame(height: 20)
                scrollerTitle("First scroller title")
                HorizontalScroller(animation: animation, items: Array(21...30).map { "Item \($0)" })
                Spacer()
            }
            .onAppear {
                showItems = true
            }
        }
        .background(Color.black)
        Spacer()
    }
    
    func scrollerTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
    }
}

#Preview {
    @Namespace var animation
    @State var globalState = GlobalState(navigation: .home([.main]))
    @State var animationCoordinator = AnimationCoordinator()
    
    return HorizontalScrollerView(animation: animation)
        .environmentObject(globalState)
        .environmentObject(animationCoordinator)
}
