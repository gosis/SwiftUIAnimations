//
//  LoginRouter.swift
//  Animations
//
//  Created by Gints Osis on 30/09/2024.
//

import Foundation

class LoginRouter: ObservableObject {
    @Published var navigation: [LoginNavigation] = [.main]
    
    func push(_ navigable: any Navigable) {
        if let homeNav = navigable as? LoginNavigation {
            navigation.append(homeNav)
        } else {
            print("Unknown navigation type")
        }
    }
    
    func pop<T: Navigable>(_ type: T.Type) {
        if type == LoginNavigation.self {
            if !navigation.isEmpty {
                navigation.removeLast()
            }
        } else {
            print("Unknown navigation type")
        }
    }
}
