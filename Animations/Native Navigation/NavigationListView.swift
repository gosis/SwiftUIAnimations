//
//  NavigationListView.swift
//  Animations
//
//  Created by Gints Osis on 01/10/2024.
//

import SwiftUI

struct NavigationListView: View {
    
    var animation: Namespace.ID
    
    let items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
        .navigationTitle("List View")
    }
}
