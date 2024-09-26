//
//  Router.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

import Foundation


class Router: ObservableObject {
    @Published var selectedTab: Tab = .firstTab
    @Published var tabBarHidden: Bool = false
    
    @Published var homeNavigation: [HomeNavigation] = [.main]
    @Published var horizontalScrollNavigation: [HorizontalScrollNavigation] = [.main]
    @Published var tableNavigation: [TableNavigation] = [.animatedImageListView]
    @Published var loadingListNavigation: [LoadingListNavigation] = [.main]
    
    let tabHiddenRoutes: Set<Int> = [
        HomeNavigation.detail("").associatedValue,
        HorizontalScrollNavigation.detail("").associatedValue,
        TableNavigation.animatedImageListItemView("").associatedValue,
        TableNavigation.animatedImageListDetailView2("").associatedValue,
        TableNavigation.animatedImageListDetailView3("").associatedValue,
        LoadingListNavigation.detail(0).associatedValue
    ]
    
    func push(_ navigable: any Navigable) {
        if let homeNav = navigable as? HomeNavigation {
            homeNavigation.append(homeNav)
        } else if let horizontalNav = navigable as? HorizontalScrollNavigation {
            horizontalScrollNavigation.append(horizontalNav)
        } else if let tableNav = navigable as? TableNavigation {
            tableNavigation.append(tableNav)
        } else if let tableNav = navigable as? LoadingListNavigation {
            loadingListNavigation.append(tableNav)
        } else {
            print("Unknown navigation type")
        }
    }
    
    func pop<T: Navigable>(_ type: T.Type) {
        if type == HomeNavigation.self {
            if !homeNavigation.isEmpty {
                homeNavigation.removeLast()
            }
        } else if type == HorizontalScrollNavigation.self {
            if !horizontalScrollNavigation.isEmpty {
                horizontalScrollNavigation.removeLast()
            }
        } else if type == TableNavigation.self {
            if !tableNavigation.isEmpty {
                tableNavigation.removeLast()
            }
        } else if type == LoadingListNavigation.self {
            if !loadingListNavigation.isEmpty {
                loadingListNavigation.removeLast()
            }
        } else {
            print("Unknown navigation type")
        }
    }
    
    func needsToHideTabbar() -> Bool {
        let topNavigable: (any Navigable)?
            
        switch selectedTab {
        case .firstTab:
            topNavigable = homeNavigation.last
        case .secondTab:
            topNavigable = horizontalScrollNavigation.last
        case .thirdTab:
            topNavigable = tableNavigation.last
        case .fourthTab:
            topNavigable = loadingListNavigation.last
        }
        
        if let associatedValue = topNavigable?.associatedValue {
            return tabHiddenRoutes.contains(associatedValue)
        }
        
        return false
    }
}
