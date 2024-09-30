//
//  LoginView.swift
//  Animations
//
//  Created by Gints Osis on 30/09/2024.
//

import SwiftUI

struct NewUserView: View {
    @EnvironmentObject var router: LoginRouter
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    
    @State private var username: String = ""
    @State private var role: String = ""
    @State private var nickname: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationBar(title: "Register") {
                let previousSourceKey = String(describing: LoginView.self)
                withAnimation(.linear(duration: AppConstants.loginAnimationDuration)) {
                    animationCoordinator.removeState(sourceKey: previousSourceKey)
                    router.pop(LoginNavigation.self)
                }
            }
            TextField("User name", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            TextField("Nickname", text: $nickname)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            TextField("Role in the company", text: $role)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Button(action: {
                register()
            }) {
                Text("Finish registration")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
        .background(Color.purple)
    }
    
    // Dummy login function
    func register() {
    }
}

#Preview {
    let animationCoordinator = AnimationCoordinator()
    let router = Router()
    @Namespace var animation: Namespace.ID
    return NewUserView(animation: animation)
        .environmentObject(animationCoordinator)
        .environmentObject(router)
}
