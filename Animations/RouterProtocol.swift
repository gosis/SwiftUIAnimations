//
//  RouterProtocol.swift
//  Animations
//
//  Created by Gints Osis on 30/09/2024.
//

import Foundation

protocol Routable {
    associatedtype NavigationType: Navigable
    
    // Each router should have an array of navigation stacks for different screens/tabs
    var navigationStacks: [NavigationType: [NavigationType]] { get set }
    
    // Push a new navigation type onto the correct stack
    func push(_ navigable: NavigationType)
    
    // Pop the last navigation type from the correct stack
    func pop(_ navigableType: NavigationType)
    
    // Get the last navigable in the stack for a given tab or section
    func topNavigable(for type: NavigationType) -> NavigationType?
    
    // Determines whether the tab bar should be hidden
    func needsToHideTabbar() -> Bool
}
