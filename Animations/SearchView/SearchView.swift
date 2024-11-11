//
//  SearchView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    
    @State private var showItems = false
            
    let sourceKey = String(describing: SearchView.self)
    
    var body: some View {
        ZStack {
            VStack {
                scrollerTitle("First scroller title")
                HorizontalScroller(animation: animation, items: Array(1...10).map { "Item \($0)" }, showItems: showItems)
                Spacer()
                    .frame(height: 20)
                scrollerTitle("Second scroller title")
                HorizontalScroller(animation: animation, items: Array(11...20).map { "Item \($0)" }, showItems: showItems)
                Spacer()
                    .frame(height: 20)
                scrollerTitle("Third scroller title")
                HorizontalScroller(animation: animation, items: Array(21...30).map { "Item \($0)" }, showItems: showItems)
                Spacer()
            }
        }
        .onChange(of: router.selectedTab) { newTab in
            showItems = newTab == .secondTab
        }
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
    @State var router = Router()
    @State var animationCoordinator = AnimationCoordinator()
    
    return SearchView(animation: animation)
        .environmentObject(router)
        .environmentObject(animationCoordinator)
}
