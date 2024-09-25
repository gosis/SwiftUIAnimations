import SwiftUI
import Combine

class LoadingListViewModel: ObservableObject {
    @Published var items: [Int] = []
    @Published var isLoading: Bool = false
    
    private var currentPage = 0
    private let itemsPerPage = 30
    private let totalItems = 300
    
    init() {
        loadNextItems() // Load the first set of items
    }

    func loadNextItems() {
        guard !isLoading else { return }
        
        isLoading = true
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, totalItems)
        
        // Simulate a network or data fetch delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newItems = Array(startIndex..<endIndex)
            self.items.append(contentsOf: newItems)
            self.currentPage += 1
            self.isLoading = false
        }
    }
}
