//
//  FirebaseauthManager.swift
//  NeoChat
//
//  Created by Shreyas on 17/11/25.
//

import FirebaseAuth
import SwiftUI
import SignInAppleAsync

struct FirebaseAuthService: AuthService {

    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            let listener = Auth.auth().addStateDidChangeListener { _, currentUser in
                if let currentUser {
                    let user = UserAuthInfo(user: currentUser)
                    continuation.yield(user)
                } else {
                    continuation.yield(nil)
                }
            }

            onListenerAttached(listener)
        }
    }

    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(user: user)
        }

        return nil
    }

    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        return result.asAuthInfo
    }

    func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = SignInWithAppleHelper()
        let response = try await helper.signIn()

        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )

        // Try to link to existing anonymous account
        if let user = Auth.auth().currentUser, user.isAnonymous {
            do {
                let result = try await user.link(with: credential)
                return result.asAuthInfo
            } catch let error as NSError {
                let authError = AuthErrorCode(rawValue: error.code)

                switch authError {
                case .providerAlreadyLinked, .credentialAlreadyInUse:
                    // Authenticate with secondary credential Apple ID is already linked with another anonymous user
                    if let secondaryCrendential = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                        let result = try await Auth.auth().signIn(with: secondaryCrendential)
                        return result.asAuthInfo
                    }
                default:
                    break
                }
            }
        }

        // Otherwise sign in to new account
        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthInfo
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }

        try await user.delete()
    }

    enum AuthError: LocalizedError {
        case userNotFound

        var errorDescription: String? {
            switch self {
            case .userNotFound:
                "Authenticated user not found"
            }
        }
    }
}

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
