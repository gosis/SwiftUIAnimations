//
//  GlobalState.swift
//  Animations
//
//  Created by Gints Osis on 24/09/2024.
//

import Foundation

class GlobalState: ObservableObject {
    @Published var navigation: AppNavigation
    @Published var selectedItem: String?
    
    init(navigation: AppNavigation) {
        self.navigation = navigation
    }
}

enum AppNavigation: Identifiable, Equatable {
    static func == (lhs: AppNavigation, rhs: AppNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    case home(HomeNavigation)
    case search
    case profile
    case table([TableNavigation])
    
    var id: String {
        switch self {
            case .home: return "home"
            case .search: return "search"
            case .profile: return "profile"
            case .table(_): return "table"
        }
    }
    
    mutating func pushTableNavigation(_ newNavigation: TableNavigation) {
        switch self {
        case .table(var stack):
            stack.append(newNavigation)
            self = .table(stack)
        default:
            break
        }
    }
    
    mutating func popFromTableNavigation() {
        switch self {
        case .table(var stack):
            if !stack.isEmpty {
                stack.removeLast()
            }
            self = .table(stack)
        default:
            break
        }
    }
}

enum TableNavigation: Identifiable, Hashable {
    case animatedImageListView
    case animatedImageListItemView(String)
    case animatedImageListDetailView2(String)
    case animatedImageListDetailView3(String)

    // Use the associated values to generate a unique ID
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

enum HomeNavigation: Identifiable {
    case main
    case list
    
    var id: String {
        switch self {
            case .main: return "main"
            case .list: return "list"
        }
    }
}