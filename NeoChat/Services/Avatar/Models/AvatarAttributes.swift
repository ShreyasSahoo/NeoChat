//
//  AvatarAttributes.swift
//  NeoChat
//
//  Created by Shreyas on 07/11/25.
//

import Foundation

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation

    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }

    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }

    var characterDescription: String {
        let prefix = characterOption.startsWithAVowel ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in a \(characterLocation.rawValue)"
    }
}

enum CharacterOption: String, CaseIterable, Hashable {
    case man, woman, alien, dog, cat

    static var `default`: Self {
        .man
    }

    var startsWithAVowel: Bool {
        switch self {
        case .alien:
            return true
        default:
            return false
        }
    }
}

enum CharacterAction: String, CaseIterable, Hashable {
    case smiling, sitting, playing, dancing, crying, sleeping, laughing, hugging

    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation: String, CaseIterable, Hashable {
    case park, mall, museum, city, beach, forest, mountain, desert, underwater, space

    static var `default`: Self {
        .park
    }
}
