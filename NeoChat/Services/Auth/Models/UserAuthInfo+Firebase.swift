//
//  UserAuthInfo+Firebase.swift
//  NeoChat
//
//  Created by Shreyas on 17/11/25.
//

import FirebaseAuth

extension UserAuthInfo {

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
