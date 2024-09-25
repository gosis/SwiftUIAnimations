import SwiftUI

struct CustomCell: View {
    var item: Int
    
    var body: some View {
        HStack {
            Text("Item \(item)")
                .font(.headline)
                .padding()
            Spacer()
            Image(systemName: "star")
                .foregroundColor(.yellow)
                .padding()
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct LoadingListView: View {
    @StateObject private var viewModel = LoadingListViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                ParallaxCirclesView()
                    .opacity(0.1)
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                    .cornerRadius(40)
                    .clipped()
                    .padding()
                    .zIndex(1000)
            }
            .frame(height: 200)
            LazyVStack {
                ForEach(viewModel.items, id: \.self) { item in
                    itemView(for: item)
                        .onAppear {
                            if item == viewModel.items.last {
                                viewModel.loadNextItems()
                            }
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView("")
                        .padding()
                }
            }
            .padding(.vertical)
        }
    }
    
    @ViewBuilder
    private func itemView(for item: Int) -> some View {
        Text("Item \(item)")
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

#Preview {
    LoadingListView()
}
