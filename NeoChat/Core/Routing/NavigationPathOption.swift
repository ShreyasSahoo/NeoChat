//
//  NavigationPathOption.swift
//  NeoChat
//
//  Created by Shreyas on 17/11/25.
//

import Foundation
import SwiftUI

enum NavigationPathOption: Hashable {
    case chat(avatarId: String)
    case category(category: CharacterOption, imageName: String)
}

extension View {
    func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
        self
            .navigationDestination(for: NavigationPathOption.self) { newValue in
                switch newValue {
                case .chat(avatarId: let avatarId):
                    ChatView(avatarId: avatarId)
                case .category(category: let category, imageName: let imageName):
                    CategoryListView(category: category, imageName: imageName, path: path)
                }
            }
    }
}
