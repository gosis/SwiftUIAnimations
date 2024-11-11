import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var items: [Int] = []
    @Published var isLoading: Bool = false
    
    private var currentPage = 0
    private let itemsPerPage = 30
    private let totalItems = 300
    
    init() {
        loadNextItems()
    }

    func loadNextItems() {
        guard !isLoading else { return }
        
        isLoading = true
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, totalItems)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newItems = Array(startIndex..<endIndex)
            self.items.append(contentsOf: newItems)
            self.currentPage += 1
            self.isLoading = false
        }
    }
}
