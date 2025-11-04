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
    @State private var popularAvatars: [AvatarModel] = AvatarModel.mocks

    var body: some View {
        NavigationStack {
            List {
                featuredSection
                categorySection
                popularSection
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
                    .anyButton {
                        print("Cell Tapped")
                    }
                }
            }.removeListFormatting()
        } header: {
            Text("Featured")
        }
    }

    private var categorySection: some View {
        Section {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryCellView(image: Constants.randomImageURL, text: category.rawValue.capitalized)
                                .anyButton {
                                    print("Cell Tapped")
                                }
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

    private var popularSection: some View {
        Section {
            ForEach(popularAvatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton {
                    print("Cell Tapped")
                }
            }
            .removeListFormatting()
        } header: {
            Text("Popular")
        }
    }
}

#Preview {
    ExploreView()
}
