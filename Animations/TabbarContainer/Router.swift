//
//  Router.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

import Foundation
import SwiftUI

/// Router  handling app navigation
class Router: ObservableObject {
    
    @Published var selectedTab: Tab = .firstTab
    
    
    /// Home tab navigation
    @Published var homeNavigation = BaseRouter<HomeNavigation>(tabbarHiddenRoutes: [HomeNavigation.detail("").associatedValue],
                                                                navigationStacks: [.main])
    
    /// Search tab navigation
    @Published var searchNavigation = BaseRouter<SearchNavigation>(tabbarHiddenRoutes: [SearchNavigation.detail("").associatedValue],
                                                                                       navigationStacks: [.main])
    
    /// Notifications tab navigation
    @Published var notificationsNavigation = BaseRouter<NotificationsNavigation>(tabbarHiddenRoutes: [NotificationsNavigation.notificationsDetailView("").associatedValue,
                                                                                                      NotificationsNavigation.notificationsDetailView2("").associatedValue,
                                                                                                      NotificationsNavigation.notificationsDetailView3("").associatedValue],
                                                                                 navigationStacks: [.notificationsView])
    
    /// Settings tab navigation
    @Published var settingsNavigation = BaseRouter<SettingsNavigation>(tabbarHiddenRoutes: [SettingsNavigation.detail(0).associatedValue],
                                                                navigationStacks: [.main])
        
    
    /// Ask active navigation if its tabbar needs to be hidden depending on its top View
    /// - Returns: true if tabbar should be hidden false Otherwise
    func needsToHideTabbar() -> Bool {
        switch selectedTab {
        case .firstTab:
            return homeNavigation.needsToHideTabbar()
        case .secondTab:
            return searchNavigation.needsToHideTabbar()
        case .thirdTab:
            return notificationsNavigation.needsToHideTabbar()
        case .fourthTab:
            return settingsNavigation.needsToHideTabbar()
        }
    }
}
