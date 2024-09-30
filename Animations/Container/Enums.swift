//
//  Enums.swift
//  Animations
//
//  Created by Gints Osis on 26/09/2024.
//

enum TableNavigation: Navigable {
    case animatedImageListView
    case animatedImageListItemView(String)
    case animatedImageListDetailView2(String)
    case animatedImageListDetailView3(String)
    
    var associatedValue: Int {
        switch self {
            case .animatedImageListView:
                return 0
            case .animatedImageListItemView(_):
                return 1
            case .animatedImageListDetailView2(_):
                return 2
            case .animatedImageListDetailView3(_):
                return 3
        }
    }

    var id: String {
        switch self {
            case .animatedImageListView:
                return "animatedImageListView"
            case .animatedImageListItemView(let item):
                return "animatedImageListItemView_\(item)"
            case .animatedImageListDetailView2(let item):
                return "animatedImageListDetailView2_\(item)"
            case .animatedImageListDetailView3(let item):
                return "animatedImageListDetailView3_\(item)"
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
    
    var associatedValue: Int {
        switch self {
            case .main: return 7
        }
    }
    
    var id: String {
        switch self {
            case .main: return "main"
        }
    }
}

enum HorizontalScrollNavigation: Navigable {
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

enum LoadingListNavigation: Navigable {
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

enum LoginNavigation: Navigable {
    case main
    case change1
    case finish
    
    var associatedValue: Int {
        switch self {
            case .main: return 12
            case .change1: return 13
            case .finish: return 13
        }
    }
    
    var id: String {
        switch self {
            case .main: return "main"
            case .change1: return "change1"
            case .finish: return "finish"
        }
    }
}
