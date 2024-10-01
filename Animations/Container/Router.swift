//
//  Router.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

import Foundation
import SwiftUI


class Router: ObservableObject {
    @Published var selectedTab: Tab = .firstTab
    @Published var tabBarHidden: Bool = false
    
    @Published var homeNavigation = BaseRouter<HomeNavigation>(tabbarHiddenRoutes: [HomeNavigation.detail("").associatedValue],
                                                                navigationStacks: [.main])
    
    @Published var horizontalScrollNavigation = BaseRouter<HorizontalScrollNavigation>(tabbarHiddenRoutes: [HorizontalScrollNavigation.detail("").associatedValue],
                                                                                       navigationStacks: [.main])
    
    @Published var tableNavigation = BaseRouter<TableNavigation>(tabbarHiddenRoutes: [TableNavigation.animatedImageListItemView("").associatedValue,
                                                                                      TableNavigation.animatedImageListDetailView2("").associatedValue,
                                                                                      TableNavigation.animatedImageListDetailView3("").associatedValue],
                                                                 navigationStacks: [.animatedImageListView])
    
    @Published var loadingListNavigation = BaseRouter<LoadingListNavigation>(tabbarHiddenRoutes: [LoadingListNavigation.detail(0).associatedValue],
                                                                navigationStacks: [.main])
        
    @Published var navigationTabPath = NavigationPath()
        
    
    func needsToHideTabbar() -> Bool {
        switch selectedTab {
        case .firstTab:
            return homeNavigation.needsToHideTabbar()
        case .secondTab:
            return horizontalScrollNavigation.needsToHideTabbar()
        case .thirdTab:
            return tableNavigation.needsToHideTabbar()
        case .fourthTab:
            return loadingListNavigation.needsToHideTabbar()
        case .fifthTab:
            return false
        }
    }
}
