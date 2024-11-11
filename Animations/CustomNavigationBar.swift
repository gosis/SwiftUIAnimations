import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    var onDismiss: () -> Void
    var onNext: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea(edges: .top)
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        onDismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    if let onNext = onNext {
                        Button(action: {
                            withAnimation(.easeInOut(duration: AppConstants.homeViewAnimDuration)) {
                                onNext()
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .padding()
                        }
                    } else {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.clear)
                            .padding()
                    }
                }
                .frame(height: 44)
            }
        }
        .zIndex(1000)
        .frame(height: 44)
    }
}

#Preview {
    CustomNavigationBar(title: "Detail View", onDismiss: {
        // Dismiss action
    }, onNext: {
        // Next action
    })
}
