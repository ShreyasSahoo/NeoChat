//
//  AvatarModel.swift
//  NeoChat
//
//  Created by Shreyas on 25/10/25.
//

import Foundation

struct AvatarModel: Hashable {

    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String?
    let dateCreated: Date?

    init(
        avatarId: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        authorId: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.authorId = authorId
        self.dateCreated = dateCreated
    }

    var characterDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }

    static var mock: AvatarModel {
        mocks[0]
    }

    static var mocks: [AvatarModel] = [
        .init(avatarId: "1", name: "Alpha", characterOption: .man, characterAction: .sitting, characterLocation: .underwater, profileImageName: Constants.randomImageURL, authorId: "123", dateCreated: Date()),
        .init(avatarId: "2", name: "Beta", characterOption: .alien, characterAction: .smiling, characterLocation: .city),
        .init(avatarId: "3", name: "Gemma", characterOption: .woman, characterAction: .crying, characterLocation: .beach),
        .init(avatarId: "4", name: "Delta", characterOption: .dog, characterAction: .hugging, characterLocation: .park),
        ]
}

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
        "A \(characterOption.rawValue) that is \(characterAction.rawValue) in a \(characterLocation.rawValue)"
    }
}

enum CharacterOption: String, CaseIterable, Hashable {
    case man, woman, alien, dog, cat

    static var `default`: Self {
        .man
    }
}

enum CharacterAction: String {
    case smiling, sitting, playing, dancing, crying, sleeping, laughing, hugging

    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation: String {
    case park, mall, museum, city, beach, forest, mountain, desert, underwater, space

    static var `default`: Self {
        .park
    }
}
