//
//  LoginView.swift
//  Animations
//
//  Created by Gints Osis on 30/09/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: LoginRouter
    @EnvironmentObject var animationCoordinator: AnimationCoordinator
    
    var animation: Namespace.ID
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    let sourceKey = String(describing:LoginView.self)
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 20)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .padding()
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none) // No capital letters for email
                
                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(10)
                
                ZStack {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            login()
                        }
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    // Dummy login function
    func login() {
        withAnimation(.spring(duration: AppConstants.loginAnimationDuration)) {
            animationCoordinator.addState(item: "login", sourceKey: sourceKey)
            router.push(LoginNavigation.change1)
        }
    }
}

#Preview {
    @Namespace var animation: Namespace.ID
    let animationCoordinator = AnimationCoordinator()
    let router = LoginRouter()
    return LoginView(animation: animation)
        .environmentObject(animationCoordinator)
        .environmentObject(router)
}
