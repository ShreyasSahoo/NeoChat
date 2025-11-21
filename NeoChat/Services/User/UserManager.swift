//
//  UserManager.swift
//  NeoChat
//
//  Created by Shreyas on 18/11/25.
//

import SwiftUI
import SwiftfulUtilities
import FirebaseFirestore

@MainActor
@Observable
class UserManager {

    private let remoteService: RemoteUserService
    private let localService: LocalUserPersistance

    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?

    init(services: UserServices) {
        self.remoteService = services.remoteService
        self.localService = services.localService
        self.currentUser  = localService.getCurrentUser()
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try remoteService.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }

    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }

    func deleteCurrentUser() async throws {
        let userId = try currentUserId()
        try await remoteService.deleteUser(userId: userId)
        signOut()
    }

    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()

        Task {
            do {
                for try await value in remoteService.streamUser(userId: userId, onListenerConfigured: { listener in
                    self.currentUserListener = listener
                }) {
                    self.currentUser = value
                    self.saveCurrentUserLocally()
                    print("Successfully listened to user: \(value.userId)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }

    func currentUserId() throws -> String {
        guard let userId = currentUser?.userId else {
            throw UserManagerError.noUserId
        }
        return userId
    }

    func markOnboardingCompletedForCurrentUser(profileColorHex: String) async throws {
        let userId = try currentUserId()
        try await remoteService.markOnboardingCompleted(userId: userId, profileColorHex: profileColorHex)
    }

    private func saveCurrentUserLocally() {
        do {
            try localService.saveCurrentUser(user: currentUser)
            print("Success saved current user locally")
        } catch {
            print("ERROR: Failed to save current user locally")
        }
    }

    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
