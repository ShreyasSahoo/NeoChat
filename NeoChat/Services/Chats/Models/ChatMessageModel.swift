//
//  ChatMessageModel.swift
//  NeoChat
//
//  Created by Shreyas on 04/11/25.
//

import Foundation

struct ChatMessageModel {
    let id: String
    let chatId: String
    let authorId: String
    let content: String
    let seenByIds: [String]?
    let dateCreated: Date?

    static var mock: ChatMessageModel = mocks[0]

    static var mocks: [ChatMessageModel] = [
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: ChatModel.mocks[0].id,
            authorId: "user_001",
            content: "Hey, how’s it going?",
            seenByIds: ["user_002"],
            dateCreated: Date().adding(minutes: -15)
        ),
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: ChatModel.mocks[0].id,
            authorId: "user_002",
            content: "All good! Just working on the new app. You?",
            seenByIds: ["user_001"],
            dateCreated: Date().adding(minutes: -10)
        ),
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: ChatModel.mocks[1].id,
            authorId: "user_003",
            content: "Did you check the new design draft?",
            seenByIds: ["user_004"],
            dateCreated: Date().adding(hours: -1)
        ),
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: ChatModel.mocks[2].id,
            authorId: "user_004",
            content: "Yes, looks great! Let’s finalize it tomorrow.",
            seenByIds: ["user_003", "user_001"],
            dateCreated: Date().adding(hours: -0, minutes: -45)
        )
    ]
}
