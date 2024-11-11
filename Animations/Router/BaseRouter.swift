//
//  BaseRouter.swift
//  Animations
//
//  Created by Gints Osis on 01/10/2024.
//

import Foundation

/// Navigation stack for a single tab of type Navigable
class BaseRouter<NavigationType: Navigable>: ObservableObject, Routable {
    
    /// Set of hidden tab enums
    @Published var tabbarHiddenRoutes: Set<Int>
    
    /// Array of possible views
    @Published var navigationStacks: [NavigationType]
    
    /// Initialise a navigation for a single tab
    /// - Parameters:
    ///   - tabbarHiddenRoutes: set of tabbar hidden routes
    ///   - navigationStacks: array of all possible navigation cases
    init(tabbarHiddenRoutes: Set<Int>, navigationStacks: [NavigationType]) {
        self.tabbarHiddenRoutes = tabbarHiddenRoutes
        self.navigationStacks = navigationStacks
    }
}
