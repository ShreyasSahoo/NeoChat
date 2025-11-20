//
//  UserManager.swift
//  NeoChat
//
//  Created by Shreyas on 18/11/25.
//

import SwiftUI
import FirebaseFirestore
import SwiftfulUtilities
import SwiftfulFirestore

protocol UserService: Sendable {
    func saveUser(user: UserModel) throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}

struct FirebaseUserService: UserService {

    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }

    func saveUser(user: UserModel) throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }

    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId, onListenerConfigured: onListenerConfigured)
    }

    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }

    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }
}

struct MockUserService: UserService {

    let currentUser: UserModel?

    init(user: UserModel? = nil) {
        self.currentUser = user
    }

    func saveUser(user: UserModel) throws {

    }
    
    func streamUser(userId: String, onListenerConfigured: @escaping (any ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {

    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {

    }
    

}

@MainActor
@Observable
class UserManager {

    private(set) var currentUser: UserModel?
    private let service: UserService
    private var currentUserListener: ListenerRegistration?

    init(service: UserService) {
        self.service = service
        self.currentUser  = nil
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try service.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid )
    }

    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }

    func deleteCurrentUser() async throws {
        let userId = try currentUserId()
        try await service.deleteUser(userId: userId)
        signOut()
    }

    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()

        Task {
            do {
                for try await value in service.streamUser(userId: userId, onListenerConfigured: { listener in
                    self.currentUserListener = listener
                }) {
                    self.currentUser = value
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
        try await service.markOnboardingCompleted(userId: userId, profileColorHex: profileColorHex)
    }

    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
