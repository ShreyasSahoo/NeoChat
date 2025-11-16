//
//  CategoryListView.swift
//  NeoChat
//
//  Created by Shreyas on 15/11/25.
//

import SwiftUI

struct CategoryListView: View {
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomImageURL
    @State private var avatars: [AvatarModel] = AvatarModel.mocks
    @Binding var path: [NavigationPathOption]

    var body: some View {
        List {
            CategoryCellView(
                image: imageName,
                text: category.rawValue.capitalized,
                cornerRadius: 0,
                font: .largeTitle
            )
            .removeListFormatting()

            ForEach(avatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton(.highlight, action: {
                    onAvatarPressed(avatar: avatar)
                })
                .removeListFormatting()
            }
        }
        .ignoresSafeArea()
        .listStyle(PlainListStyle())
    }

    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    CategoryListView(path: .constant([]))
}
