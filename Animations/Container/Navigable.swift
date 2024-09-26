//
//  Navigable.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

protocol Navigable: Identifiable, Hashable {
    var id: String { get }
    var associatedValue: Int { get }
}
