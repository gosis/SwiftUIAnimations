import SwiftUI

struct LoginContainerView: View {
    @ObservedObject var loginRouter = LoginRouter()
    @ObservedObject var animationCoordinator = AnimationCoordinator()
    
    @Namespace var animation: Namespace.ID
    
    var body: some View {
        loginNavigationStack(animation: animation,
                             loginNavigation: loginRouter.navigation)
            .environmentObject(loginRouter)
            .environmentObject(animationCoordinator)
    }
    
    func loginNavigationStack(animation: Namespace.ID,
                        loginNavigation: [LoginNavigation]) -> some View {
        ZStack {
            ForEach(loginNavigation, id: \.id) { navigation in
                switch navigation {
                    case .main:
                        LoginView(animation: animation)
                        .zIndex(1)
                        .background(Color.purple)
                case .change1:
                    LoginChange1View(animation: animation)
                        .zIndex(2)
                        .modifier(CurvedInteractiveDragModifier(animationCoordinator: animationCoordinator,
                                                          loginRouter: loginRouter,
                                                          sourceKey: String(describing: LoginChange1View.self)))
                        .transition(.navigationTransition)
                    case .finish:
                        NewUserView(animation: animation)
                            .zIndex(3)
                            .modifier(CurvedInteractiveDragModifier(animationCoordinator: animationCoordinator,
                                                              loginRouter: loginRouter,
                                                              sourceKey: String(describing: NewUserView.self)))
                            .transition(.navigationTransition)
                }
            }
        }
    }
}

#Preview {
    LoginContainerView()
}
