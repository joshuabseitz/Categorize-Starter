//
//  SignInView.swift
//  Categorize
//
//  Created by Joshua Seitz on 6/16/24.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @ObservedObject var authViewModel = AuthViewModel.shared

    var body: some View {
        VStack {
            if authViewModel.user == nil {
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        authViewModel.handleSignInWithAppleRequest(request)
                    },
                    onCompletion: { result in
                        authViewModel.handleSignInWithAppleCompletion(result)
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(width: 280, height: 60)
                .padding()
            } else {
                Text("Welcome, \(authViewModel.user?.displayName ?? "User")")
                // Navigation to HomeView can be added here
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
