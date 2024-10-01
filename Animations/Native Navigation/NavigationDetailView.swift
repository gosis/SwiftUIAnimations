//
//  NavigationDetailView.swift
//  Animations
//
//  Created by Gints Osis on 01/10/2024.
//

import SwiftUI

struct NavigationDetailView: View, Hashable {
    
    let id: UUID = UUID()
    var animation: Namespace.ID
    
    static func == (lhs: NavigationDetailView, rhs: NavigationDetailView) -> Bool {
           lhs.id == rhs.id
   }
   
   func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
    
    var body: some View {
        ZStack {
            Color.cyan
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding()
                
                Text("Detail Screen")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("Detail")
        }.ignoresSafeArea()
    }
}

#Preview {
    @Namespace var animation
    NavigationDetailView(animation: animation)
}
