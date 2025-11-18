//
//  UserManager.swift
//  NeoChat
//
//  Created by Shreyas on 18/11/25.
//

import SwiftUI
import FirebaseFirestore
import SwiftfulUtilities

protocol UserService: Sendable {
    func saveUser(user: UserModel) throws
}

struct FirebaseUserService: UserService {

    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }

    func saveUser(user: UserModel) throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
}

@MainActor
@Observable
class UserManager {

    private(set) var currentUser: UserModel?
    private let service: UserService

    init(service: UserService) {
        self.service = service
        self.currentUser  = nil
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try service.saveUser(user: user)
    }
}
