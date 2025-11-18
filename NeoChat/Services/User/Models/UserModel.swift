//
//  UserModel.swift
//  NeoChat
//
//  Created by Shreyas on 06/11/25.
//

import SwiftUI

struct UserModel: Codable {

    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationVersion: String?
    let creationDate: Date?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?

    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationVersion: String? = nil,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationVersion = creationVersion
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }

    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationVersion: creationVersion,
            creationDate: auth.creationDate,
            lastSignInDate: auth.lastSignInDate
        )
    }

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationVersion = "creation_version"
        case creationDate = "creation_date"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
    }

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
                email: "alice.johnson@example.com",
                isAnonymous: false,
                creationVersion: "1.0",
                creationDate: Date().adding(days: -10, hours: -3),
                lastSignInDate: Date().adding(days: -1, hours: -2),
                didCompleteOnboarding: true,
                profileColorHex: "#FF6B35"
            ),
            UserModel(
                userId: "user_002",
                email: "bob.smith@example.com",
                isAnonymous: false,
                creationVersion: "1.1",
                creationDate: Date().adding(days: -9, hours: -1),
                lastSignInDate: Date().adding(hours: -5),
                didCompleteOnboarding: true,
                profileColorHex: "#2EC4B6"
            ),
            UserModel(
                userId: "user_003",
                email: nil,
                isAnonymous: true,
                creationVersion: "1.0",
                creationDate: Date().adding(days: -7, hours: -5),
                lastSignInDate: Date().adding(days: -2, hours: -1),
                didCompleteOnboarding: false,
                profileColorHex: "#4A4A4A"
            ),
            UserModel(
                userId: "user_004",
                email: "charlie.davis@example.com",
                isAnonymous: false,
                creationVersion: "1.2",
                creationDate: Date().adding(days: -5, hours: -2),
                lastSignInDate: Date().adding(hours: -8),
                didCompleteOnboarding: true,
                profileColorHex: "#5C6BC0"
            )
        ]
    }

}
