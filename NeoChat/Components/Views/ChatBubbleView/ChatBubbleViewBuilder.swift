//
//  ChatBubbleViewBuilder.swift
//  NeoChat
//
//  Created by Shreyas on 08/11/25.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {

    var message: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?

    var body: some View {
        ChatBubbleView(
            text: message.content,
            textColor: isCurrentUser ? .white : .primary,
            backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray6),
            showImage: !isCurrentUser,
            imageName: imageName
        )
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? 75 : 0)
        .padding(.trailing, isCurrentUser ? 0 : 75)
    }
}

#Preview {
    VStack(spacing: 24) {
        ChatBubbleViewBuilder(isCurrentUser: true)
        ChatBubbleViewBuilder()
        ChatBubbleViewBuilder(message: .init(id: UUID().uuidString, chatId: UUID().uuidString, authorId: UUID().uuidString, content: "Hello World! This is a very long message that spans over mutliple lines! This actually wraps across  lines.", seenByIds: nil, dateCreated: .now), isCurrentUser: true)

        ChatBubbleViewBuilder(message: .init(id: UUID().uuidString, chatId: UUID().uuidString, authorId: UUID().uuidString, content: "Hello World! This is a very long message that spans over mutliple lines! This actually wraps across  lines.", seenByIds: nil, dateCreated: .now))
    }
    .padding()
}
