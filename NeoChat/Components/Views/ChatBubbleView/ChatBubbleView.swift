//
//  ChatBubbleView.swift
//  NeoChat
//
//  Created by Shreyas on 07/11/25.
//

import SwiftUI

struct ChatBubbleView: View {
    var text: String = "Hello, World"
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray6)
    var showImage: Bool = true
    var imageName: String?
    var offset: CGFloat = 8

    var body: some View {

        HStack(alignment: .top, spacing: 8) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName)
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .clipShape(Circle())
                .frame(width: 45, height: 45)
                .offset(y: offset)
            }

            Text(text)
                .font(.body)
                .foregroundColor(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(8)
        }
        .padding(.vertical, showImage ? offset : 0)
    }
}

#Preview {

    VStack {
        ChatBubbleView(
            text: "This is a sample chat bubble view",
            imageName: Constants.randomImageURL,
            offset: 8
        )

        ChatBubbleView(
            text: " This is a sample chat bubble view This is a sample chat bubble view This is a sample chat bubble view This is a sample chat bubble view This is a sample chat bubble view",
            imageName: Constants.randomImageURL,
            offset: 8
        )

        ChatBubbleView(text: "This is a sample chat bubble view", textColor: .white, backgroundColor: .red, showImage: false, imageName: nil, offset: 8)

        ChatBubbleView(text: "This is a sample chat bubble view This is a sample chat bubble view This is a sample chat bubble view This is a sample chat bubble view This is a sample chat bubble view", textColor: .white, backgroundColor: .red, showImage: false, imageName: nil, offset: 8)
    }
    .padding()
}
