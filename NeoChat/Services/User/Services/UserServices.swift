//
//  UserServices.swift
//  NeoChat
//
//  Created by Shreyas on 21/11/25.
//

import Foundation

protocol UserServices {
    var remoteService: RemoteUserService { get }
    var localService: LocalUserPersistance { get }
}

struct ProductionUserServices: UserServices {
    let remoteService: RemoteUserService = FirebaseUserService()
    let localService: LocalUserPersistance = FileManagerUserPersistance()
}

struct MockUserServices: UserServices {
    let remoteService: RemoteUserService
    let localService: LocalUserPersistance

    init(user: UserModel? = nil) {
        remoteService = MockUserService(user: user)
        localService = MockUserPersistance(user: user)
    }
}
