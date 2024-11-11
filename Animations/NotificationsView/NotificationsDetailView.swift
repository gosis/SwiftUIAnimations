//
//  MainView.swift
//  Animations
//
//  Created by Gints Osis on 30/08/2024.
//

import SwiftUI

struct NotificationsDetailView: View {
    var animation: Namespace.ID
    @EnvironmentObject var router: Router
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var item: String
    var body: some View {
        ZStack {
            Color.gray
                .matchedGeometryEffect(id: "\(item)_cell", in: animation)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                let sourceKey = String(describing: NotificationsView.self)
                let nextSourceKey = String(describing: NotificationsDetailView2.self)
                if animationCoordinator.isActive(sourceKey: sourceKey) {
                    CustomNavigationBar(title: "Detail View", onDismiss: {
                        withAnimation(.linear(duration: AppConstants.notificationsAnimDuration)) {
                            animationCoordinator.removeState(sourceKey: sourceKey)
                            router.notificationsNavigation.pop()
                        }
                       }, onNext: {
                           withAnimation(.linear(duration: AppConstants.notificationsAnimDuration)) {
                               animationCoordinator.addState(item: item, sourceKey: sourceKey)
                               router.notificationsNavigation.push(.notificationsDetailView2(item))
                           }
                       })
                }
                
                if !animationCoordinator.isActive(sourceKey: nextSourceKey) {
                    Image("logo")
                        .resizable()
                        .matchedGeometryEffect(id: "\(item)_image", in: animation)
                        .frame(width: 200, height: 200)
                    Text(item)
                        .matchedGeometryEffect(id: "\(item)_text", in: animation)
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
        }
    }
}


#Preview {
    @State var router = Router()
    @State var animationCoordinator = AnimationCoordinator()
    @Namespace var animation
    return NotificationsDetailView(animation: animation,
                                       item: "test")
        .environmentObject(router)
        .environmentObject(animationCoordinator)
}
