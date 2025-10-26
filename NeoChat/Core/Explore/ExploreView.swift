//
//  ExploreView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ExploreView: View {

    let avatar: AvatarModel = .mock

    var body: some View {
        NavigationStack {
            HeroCellView(
                title: avatar.name,
                subtitle: avatar.characterDescription,
                imageName: avatar.profileImageName
            )
            .frame(width: 350, height: 200)
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
