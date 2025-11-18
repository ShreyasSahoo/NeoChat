//
//  MockauthManager.swift
//  NeoChat
//
//  Created by Shreyas on 18/11/25.
//

import Foundation

struct MockAuthService: AuthService {

    let currentUser: UserAuthInfo?

    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }

    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            continuation.yield(currentUser)
        }
    }

    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, true)
    }
    
    func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: false)
        return (user, true)
    }
    
    func signOut() throws {

    }
    
    func deleteAccount() async throws {

    }
}
