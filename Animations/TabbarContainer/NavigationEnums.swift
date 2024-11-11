//
//  NavigationEnums.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

enum NotificationsNavigation: Navigable {
    case notificationsView
    case notificationsDetailView(String)
    case notificationsDetailView2(String)
    case notificationsDetailView3(String)
    
    var associatedValue: Int {
        switch self {
            case .notificationsView:
                return 0
            case .notificationsDetailView(_):
                return 1
            case .notificationsDetailView2(_):
                return 2
            case .notificationsDetailView3(_):
                return 3
        }
    }

    var id: String {
        switch self {
            case .notificationsView:
                return "notificationsView"
            case .notificationsDetailView(let item):
                return "notificationsDetailView_\(item)"
            case .notificationsDetailView2(let item):
                return "notificationsDetailView2_\(item)"
            case .notificationsDetailView3(let item):
                return "notificationsDetailView3_\(item)"
        }
    }
}

enum HomeNavigation: Navigable {
    case main
    case list
    case detail(String)
    
    var associatedValue: Int {
        switch self {
            case .main: return 4
            case .list: return 5
            case .detail: return 6
        }
    }
    
    var id: String {
        switch self {
            case .main: return "main"
            case .list: return "list"
            case .detail: return "detail"
        }
    }
}

enum SearchNavigation: Navigable {
    case main
    case detail(String)
    
    var associatedValue: Int {
        switch self {
            case .main: return 8
            case .detail: return 9
        }
    }
    
    var id: String {
        switch self {
            case .main: return "main"
            case .detail: return "detail"
        }
    }
}

enum SettingsNavigation: Navigable {
    case main
    case detail(Int)
    
    var associatedValue: Int {
        switch self {
            case .main: return 10
            case .detail: return 11
        }
    }
    
    var id: String {
        switch self {
            case .main: return "main"
            case .detail: return "detail"
        }
    }
}
