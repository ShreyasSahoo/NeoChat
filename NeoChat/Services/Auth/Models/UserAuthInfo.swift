//
//  UserAuthInfo.swift
//  NeoChat
//
//  Created by Shreyas on 17/11/25.
//

import SwiftUI

struct UserAuthInfo: Sendable {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?

    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }
}
