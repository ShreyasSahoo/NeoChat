//
//  ChatsView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.mocks

    var body: some View {
        NavigationStack {
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
                        // print
                    }
                    .removeListFormatting()
                }
            }
                .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
