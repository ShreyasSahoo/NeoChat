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

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] = [
        .init(avatarId: "1", name: "Alpha", characterOption: .man, characterAction: .sitting, characterLocation: .underwater, profileImageName: Constants.randomImageURL, authorId: "123", dateCreated: Date()),
        .init(avatarId: "2", name: "Beta", characterOption: .alien, characterAction: .smiling, characterLocation: .city),
        .init(avatarId: "3", name: "Gemma", characterOption: .woman, characterAction: .crying, characterLocation: .beach),
        .init(avatarId: "4", name: "Delta", characterOption: .dog, characterAction: .hugging, characterLocation: .park)
        ]
}
