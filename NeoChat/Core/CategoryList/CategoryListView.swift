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
                .removeListFormatting()
            }
        }
        .ignoresSafeArea()
        .listStyle(PlainListStyle())
    }
}

#Preview {
    CategoryListView()
}
