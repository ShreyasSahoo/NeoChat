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
    @State private var recentAvatars: [AvatarModel] = AvatarModel.mocks

    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !recentAvatars.isEmpty {
                    Section {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 12) {
                                ForEach(recentAvatars, id: \.self) { avatar in
                                    if let imageName = avatar.profileImageName {
                                        VStack(alignment: .center, spacing: 8) {
                                            ImageLoaderView(urlString: imageName)
                                                .aspectRatio(1, contentMode: .fill)
                                                .clipShape(Circle())

                                            Text(avatar.name ?? "")
                                        }
                                        .anyButton {
                                            onAvatarPressed(avatar: avatar)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 12)
                            .frame(height: 120)
                        }
                        .removeListFormatting()
                        .scrollIndicators(.hidden)
                    } header: {
                        Text("Recents")
                    }
                }

                chatsSection
            }
                .navigationTitle("Chats")
                .navigationDestinationForCoreModule(path: $path)
        }
    }

    private var chatsSection: some View {
        Section {
            if chats.isEmpty {
                Text("Your chats will appear here.")
                    .foregroundStyle(.secondary)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .removeListFormatting()
            } else {
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
                        onChatPressed(chat: chat)
                    }
                    .removeListFormatting()
                }
            }
        } header: {
            Text("Chats")
        }

    }

    private func onChatPressed(chat: ChatModel) {
        path.append(.chat(avatarId: chat.avatarId))
    }

    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    ChatsView()
}
