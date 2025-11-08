//
//  ChatView.swift
//  NeoChat
//
//  Created by Shreyas on 07/11/25.
//

import SwiftUI

struct ChatView: View {
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var currentUser: UserModel? = .mock
    @State private var avatar: AvatarModel? = .mock
    @State private var textFieldText: String = ""
    @State private var showChatSettings = false
    @State private var scrollPosition: String?

    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton {
                        onChatSettingsButtonTapped()
                    }
            }
        }
        .confirmationDialog("", isPresented: $showChatSettings) {
            Button("Report User / Chat", role: .destructive) {

            }

            Button("Delete Chat", role: .destructive) {

            }
        } message: {
            Text("What would you like to do?")
        }
    }

    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == currentUser?.userId

                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName ?? ""
                    )
                    .id(message.id)
                }
            }
            .padding(8)
            .rotationEffect(Angle(degrees: 180))
        }
        .rotationEffect(Angle(degrees: 180))
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrollPosition)
        .scrollPosition(id: $scrollPosition, anchor: .center)
    }

    private var textFieldSection: some View {
        TextField("Say something...", text: $textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 40)
            .overlay(
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundStyle(.accent)
                    .font(Font.system(size: 32))
                    .padding(.trailing, 4)
                    .anyButton {
                        onSendButtonPressed()
                    }
                , alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))

                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
    }

    private func onSendButtonPressed() {
        guard let currentUser else { return }
        let content = textFieldText

        let message = ChatMessageModel(
            id: UUID().uuidString,
            chatId: UUID().uuidString,
            authorId: currentUser.userId,
            content: content,
            seenByIds: nil,
            dateCreated: .now
        )

        chatMessages.append(message)
        scrollPosition = message.id

        textFieldText = ""
    }

    private func onChatSettingsButtonTapped() {
        showChatSettings = true
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
