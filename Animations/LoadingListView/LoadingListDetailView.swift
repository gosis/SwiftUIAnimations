//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct LoadingListDetailView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    @State private var showItems = false
    
    var item: Int
    
    let previousSourceKey = String(describing: LoadingListView.self)
    
    var body: some View {
        ZStack {
            Color.white
                .matchedGeometryEffect(id: "\(item)_cell", in: animation)
            VStack {
                if showItems {
                    CustomNavigationBar(title: "Edit view") {
                        dismiss()
                    }
                    .transition(.noTransition)
                }
                VStack {
                    Text("Item " + String(item))
                        .font(.title)
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: "\(item)_text", in: animation)
                    Image("1")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .matchedGeometryEffect(id: "\(item)_image", in: animation)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.trailing, 10)
                    let hasAnimation = animationCoordinator.isActive(sourceKey: previousSourceKey)
                    ZStack {
                        Text(hasAnimation ? "Complete" : "Edit")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    .matchedGeometryEffect(id: "\(item)_button", in: animation)
                    Spacer()
                }
                .padding(20)
                Spacer()
            }
        }
        .onAppear {
                withAnimation(.easeIn) {
                    showItems = true
                }
        }
    }
    
    func dismiss() {
        let previousSourceKey = String(describing: LoadingListView.self)
        withAnimation(.easeOut(duration: AppConstants.loadingListAnimation)) {
            showItems = false
            animationCoordinator.removeState(sourceKey: previousSourceKey)
            router.loadingListNavigation.pop()
        }
    }
}

#Preview {
    @Namespace var animation
    return LoadingListDetailView(animation: animation, item: 3)
}
