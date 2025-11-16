//
//  ChatsView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var path: [NavigationPathOption] = []

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        chat: chat,
                        currentUserId: nil,
                        getlastChatMessage: {
                            try? await Task.sleep(for: .seconds(3))
                            return .mock
                        },
                        getAvatar: {
                            try? await Task.sleep(for: .seconds(3))
                            return .mock
                        }
                    )
                    .anyButton(.highlight) {
                        onChatPressed(avatarId: chat.avatarId)
                    }
                    .removeListFormatting()
                }
            }
                .navigationTitle("Chats")
                .navigationDestinationForCoreModule(path: $path)
        }
    }

    private func onChatPressed(avatarId: String) {
        path.append(.chat(avatarId: avatarId))
    }
}

#Preview {
    ChatsView()
}
