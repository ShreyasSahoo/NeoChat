//
//  ChatRowCellViewBuilder.swift
//  NeoChat
//
//  Created by Shreyas on 06/11/25.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {
    var chat: ChatModel = .mock
    var currentUserId: String? = ""
    var getlastChatMessage: () async -> ChatMessageModel?
    var getAvatar: () async -> AvatarModel?

    @State private var avatar: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?
    @State private var didLoadAvatar: Bool = false
    @State private var didLoadChatMessage: Bool = false

    private var isLoading: Bool {
        if didLoadAvatar && didLoadChatMessage {
            return false
        }

        return true
    }

    private var hasNewChat: Bool {
        guard let lastChatMessage, let currentUserId else { return false }
        return lastChatMessage.hasBeenSeenByCurrentUser(userId: currentUserId)
    }

    private var subheadline: String? {
        if isLoading {
            return "xxxx xxxx xxxx xxxx"
        }

        if avatar == nil && lastChatMessage == nil {
            return "Error Loading Data..."
        }

        return lastChatMessage?.content
    }

    var body: some View {
        ChatRowCellView(
            imageName: isLoading ? nil : avatar?.profileImageName,
            headline: isLoading ? "xxxx xxxx" : avatar?.name,
            subheadline: subheadline,
            hasNewChat: isLoading ? false : hasNewChat
        )
        .redacted(reason: isLoading ? .placeholder : [])
        // Two Tasks so that if one fails other still executes
        .task {
            avatar = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastChatMessage = await getlastChatMessage()
            didLoadChatMessage = true
        }
    }
}

#Preview {
    ChatRowCellViewBuilder {
        try? await Task.sleep(for: .seconds(2))
        return .mock
    } getAvatar: {
        try? await Task.sleep(for: .seconds(2))
        return .mock
    }

    ChatRowCellViewBuilder {
        try? await Task.sleep(for: .seconds(2))
        return nil
    } getAvatar: {
        try? await Task.sleep(for: .seconds(2))
        return .mock
    }

}
