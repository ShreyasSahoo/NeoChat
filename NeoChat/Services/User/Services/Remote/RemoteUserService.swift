//
//  RemoteUserService.swift
//  NeoChat
//
//  Created by Shreyas on 21/11/25.
//

import Foundation

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}
