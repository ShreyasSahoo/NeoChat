//
//  ChatRowCellView.swift
//  NeoChat
//
//  Created by Shreyas on 05/11/25.
//

import SwiftUI

struct ChatRowCellView: View {
    var imageName: String? = Constants.randomImageURL
    var headline: String? = "Alpha"
    var subheadline: String? = "This is the last message in this chat..."

    var hasNewChat: Bool = true

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.2))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                if let headline {
                    Text(headline)
                        .font(.headline)
                }

                if let subheadline {
                    Text(subheadline)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if hasNewChat {
                Text("NEW")
                    .badgeButton()
            }

        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()

        List {
            ChatRowCellView(imageName: nil)
                .removeListFormatting()

            ChatRowCellView(hasNewChat: false)
                .removeListFormatting()

            ChatRowCellView()
                .removeListFormatting()

            ChatRowCellView(subheadline: nil)
                .removeListFormatting()
        }

    }
}
