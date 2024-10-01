//
//  RouterProtocol.swift
//  Animations
//
//  Created by Gints Osis on 30/09/2024.
//

import Foundation

protocol Routable {
    associatedtype NavigationType: Navigable
    
    var navigationStacks: [NavigationType] { get set }
    var tabbarHiddenRoutes: Set<Int> { get }
    
    mutating func push(_ navigable: NavigationType)
    mutating func pop()
    func topNavigable() -> NavigationType?
    func needsToHideTabbar() -> Bool
}

// Default implementations for Routable
extension Routable {
    
    mutating func push(_ navigable: NavigationType) {
        navigationStacks.append(navigable)
    }
    
    mutating func pop() {
        if !navigationStacks.isEmpty {
            navigationStacks.removeLast()
        }
    }
    
    func topNavigable() -> NavigationType? {
        return navigationStacks.last
    }
    
    func needsToHideTabbar() -> Bool {
        if let topNavigable = navigationStacks.last {
            return tabbarHiddenRoutes.contains(topNavigable.associatedValue)
        }
        return false
    }
}

