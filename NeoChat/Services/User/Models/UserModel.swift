//
//  UserModel.swift
//  NeoChat
//
//  Created by Shreyas on 06/11/25.
//

import SwiftUI

struct UserModel {

    let userId: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?

    var profileColorCalculated: Color {
        guard let profileColorHex else { return .accent }

        return Color(hex: profileColorHex)
    }

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        [
            UserModel(
                userId: "user_001",
                dateCreated: Date().adding(days: -10, hours: -3),
                didCompleteOnboarding: true,
                profileColorHex: "#FF6B35"
            ),
            UserModel(
                userId: "user_002",
                dateCreated: Date().adding(days: -9, hours: -1),
                didCompleteOnboarding: true,
                profileColorHex: "#2EC4B6"
            ),
            UserModel(
                userId: "user_003",
                dateCreated: Date().adding(days: -7, hours: -5),
                didCompleteOnboarding: false,
                profileColorHex: "#4A4A4A"
            ),
            UserModel(
                userId: "user_004",
                dateCreated: Date().adding(days: -5, hours: -2),
                didCompleteOnboarding: true,
                profileColorHex: "#5C6BC0"
            )
        ]
    }

}
