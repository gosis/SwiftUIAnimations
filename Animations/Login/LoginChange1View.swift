//
//  LoginView.swift
//  Animations
//
//  Created by Gints Osis on 30/09/2024.
//

import SwiftUI

struct LoginChange1View: View {
    @EnvironmentObject var router: LoginRouter
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    
    @State private var avatar: String = ""
    @State private var address: String = ""
    @State private var age: String = ""
    
    let sourceKey = String(describing:LoginChange1View.self)
    
    var body: some View {
        VStack(spacing: 20) {
            CustomNavigationBar(title: "Update information") {
                let previousSourceKey = String(describing: LoginView.self)
                withAnimation(.linear(duration: AppConstants.loginAnimationDuration)) {
                    animationCoordinator.removeState(sourceKey: previousSourceKey)
                    router.pop(LoginNavigation.self)
                }
            }
            TextField("My avatar", text: $avatar)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            TextField("My address", text: $address)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            TextField("My age", text: $age)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Button(action: {
                update()
            }) {
                Text("Update information")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
        .background(Color.white)
    }
    
    // Dummy login function
    func update() {
        withAnimation(.linear(duration: AppConstants.loginAnimationDuration)) {
            animationCoordinator.addState(item: "login", sourceKey: sourceKey)
            router.push(LoginNavigation.finish)
        }
    }
}

#Preview {
    let animationCoordinator = AnimationCoordinator()
    let router = Router()
    @Namespace var animation: Namespace.ID
    return LoginChange1View(animation: animation)
        .environmentObject(animationCoordinator)
        .environmentObject(router)
}
