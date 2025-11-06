//
//  ChatModel.swift
//  NeoChat
//
//  Created by Shreyas on 04/11/25.
//

import Foundation

struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date

    static var mock: Self = mocks[0]

    static var mocks: [Self] = [
            ChatModel(
                id: UUID().uuidString,
                userId: "user_001",
                avatarId: "avatar_001",
                dateCreated: Date().adding(hours: -1),
                dateModified: Date()
            ),
            ChatModel(
                id: UUID().uuidString,
                userId: "user_002",
                avatarId: "avatar_002",
                dateCreated: Date().adding(hours: -2),
                dateModified: Date().adding(minutes: -30)
            ),
            ChatModel(
                id: UUID().uuidString,
                userId: "user_003",
                avatarId: "avatar_003",
                dateCreated: Date().adding(days: -1, hours: -3),
                dateModified: Date().adding(hours: -1)
            ),
            ChatModel(
                id: UUID().uuidString,
                userId: "user_004",
                avatarId: "avatar_004",
                dateCreated: Date().adding(days: -2, hours: -5),
                dateModified: Date().adding(hours: -2)
            )
        ]
}
