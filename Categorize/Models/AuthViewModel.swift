//
//  AuthViewModel.swift
//  Categorize
//
//  Created by Joshua Seitz on 6/16/24.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class AuthViewModel: ObservableObject {
    @Published var user: User?
    private var currentNonce: String?

    static let shared = AuthViewModel()

    private init() {
        Auth.auth().addStateDidChangeListener { auth, firebaseUser in
            if let firebaseUser = firebaseUser {
                self.user = User(firebaseUser: firebaseUser)
                // Optionally, fetch additional user data from Firestore here if needed
            } else {
                self.user = nil
            }
        }
    }

    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }

    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            guard let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential else { return }
            guard let nonce = currentNonce else { fatalError("Invalid state: A login callback was received, but no login request was sent.") }
            guard let appleIDToken = appleIDCredential.identityToken else { fatalError("Invalid state: A login callback was received, but no login request was sent.") }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { print("Unable to serialize token string from data: \(appleIDToken.debugDescription)"); return }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let firebaseUser = authResult?.user {
                    self.user = User(firebaseUser: firebaseUser)
                }
            }
        case .failure(let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        self.user = nil
    }

    private func randomNonceString(length: Int = 32) -> String {
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }
}
