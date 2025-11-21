//
//  MockUserPersistance.swift
//  NeoChat
//
//  Created by Shreyas on 21/11/25.
//

import Foundation

struct MockUserPersistance: LocalUserPersistance {
    var currentUser: UserModel?

    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {

    }
}
