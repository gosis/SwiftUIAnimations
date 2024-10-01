//
//  NavigationContainerView.swift
//  Animations
//
//  Created by Gints Osis on 01/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace private var animation
    
    @EnvironmentObject var router: Router
    
    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationTabPath) {
            VStack {
                TabbarContainer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(router.selectedTab != .fifthTab)
            .navigationDestination(for: String.self) { value in
                if value == "detail" {
                    NavigationDetailView(animation: animation)
                } else if value == "list" {
                    NavigationListView(animation: animation)
                }
            }
        }
        .background(Color.white)
    }
    
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // Ensure background is not translucent
        appearance.backgroundColor = UIColor.purple // Set background color to purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title color white
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Large title color white
        
        // Apply appearance to standard and scroll edge appearances
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance // For compact appearance
    }
}

#Preview {
    let router = Router()
    return ContentView()
        .environmentObject(router)
}
