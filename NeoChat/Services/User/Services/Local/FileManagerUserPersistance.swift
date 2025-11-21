//
//  FileManagerUserPersistance.swift
//  NeoChat
//
//  Created by Shreyas on 21/11/25.
//

import Foundation

struct FileManagerUserPersistance: LocalUserPersistance {
    private let userDocumentKey = "current_user"

    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }

    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument( key: userDocumentKey, value: user)
    }
}
