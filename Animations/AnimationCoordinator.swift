//
//  AnimationCoordinator.swift
//  Animations
//
//  Created by Gints Osis on 24/09/2024.
//

import Foundation

class AnimationState: Hashable {
    let item: AnyHashable
    let navigation: AnyHashable
    
    init(item: AnyHashable, navigation: AnyHashable) {
        self.item = item
        self.navigation = navigation
    }
    
    // Conform to Hashable
    static func == (lhs: AnimationState, rhs: AnimationState) -> Bool {
        return lhs.item == rhs.item && lhs.navigation == rhs.navigation
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(item)
        hasher.combine(navigation)
    }
}


/// Simple animation coordinator for transition with matchedGeometryEffect
/// Before a view transitions an id of the animation is stored with the corresponding sourceKey
/// In sourceKey  the name of the destination component is stored
/// During and after the transition completes the destination view checks if the animation is active using isActive
/// if animation is active it means that the animated component doesn't need to be rendered in the source component or vice versa
///
/// Helps to separate source and destination views for matchedGeometryEffect transitions
class AnimationCoordinator: ObservableObject {
    
    // Dictionary to store active states with item as key
    @Published private(set) var activeStates: [String: AnyHashable] = [:]
    
    // Adds a new AnimationState
    func addState(item: AnyHashable, sourceKey: String) {
        activeStates[sourceKey] = item
    }
    
    // Removes a state by item
    func removeState(sourceKey: String) {
        activeStates.removeValue(forKey: sourceKey)
    }
    
    // Checks if a specific state is active
    func isActive(sourceKey: String) -> Bool {
        return activeStates[sourceKey] != nil
    }
    
    // Retrieves a specific state by item
    func getState(sourceKey: String) -> AnyHashable? {
        return activeStates[sourceKey]
    }
    
    // Clears all active states
    func clearAllStates() {
        activeStates.removeAll()
    }
}
