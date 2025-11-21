//
//  LocalUserPersistance.swift
//  NeoChat
//
//  Created by Shreyas on 21/11/25.
//

import Foundation

protocol LocalUserPersistance: Sendable {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
