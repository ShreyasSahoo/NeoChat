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
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(chatMessages) { message in
                        let isCurrentUser = message.authorId == currentUser?.userId
                        
                        ChatBubbleViewBuilder(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            imageName: isCurrentUser ? nil : avatar?.profileImageName ?? ""
                        )
                    }
                }
                .padding(8)
            }
            
            Rectangle()
                .frame(height: 55)
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
