//
//  ExploreView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ExploreView: View {

    @State private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection

            }
            .navigationTitle("Explore")
        }
    }

    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { avatar in
                    HeroCellView(
                        title: avatar.name,
                        subtitle: avatar.characterDescription,
                        imageName: avatar.profileImageName
                    )
                }
            }.removeListFormatting()
        } header: {
            Text("Featured Avatars")
        }
    }

    private var categorySection: some View {
        Section {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryCellView(image: Constants.randomImageURL, text: category.rawValue.capitalized)
                        }
                    }
                }
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
                .removeListFormatting()
        } header: {
            Text("Categories")
        }
    }
}

#Preview {
    ExploreView()
}
