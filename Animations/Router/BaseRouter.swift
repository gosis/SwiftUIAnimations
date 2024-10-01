//
//  BaseRouter.swift
//  Animations
//
//  Created by Gints Osis on 01/10/2024.
//

import Foundation

class BaseRouter<NavigationType: Navigable>: ObservableObject, Routable {
    
    @Published var tabbarHiddenRoutes: Set<Int>
    @Published var navigationStacks: [NavigationType]
    
    init(tabbarHiddenRoutes: Set<Int>, navigationStacks: [NavigationType]) {
        self.tabbarHiddenRoutes = tabbarHiddenRoutes
        self.navigationStacks = navigationStacks
    }
}
