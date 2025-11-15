//
//  TextValidationHelper.swift
//  NeoChat
//
//  Created by Shreyas on 09/11/25.
//
import Foundation

struct TextValidationHelper {

    enum TextValidationError: LocalizedError {
        case notEnoughCharacters(min: Int)
        case hasBadWords

        var errorDescription: String? {
            switch self {
            case .notEnoughCharacters(let min):
                "Please enter at least \(min) characters."
            case .hasBadWords:
                "Please do not use offensive language."
            }
        }
    }

    static func checkIfTextIsValid(text: String) throws {
        let minimumNumberOfCharacters: Int = 4
        let badWords: [String] = ["bad", "naughty", "scam"]

        if badWords.contains(text.lowercased()) {
            throw TextValidationError.hasBadWords
        }

        guard text.count >= minimumNumberOfCharacters else {
            throw TextValidationError.notEnoughCharacters(min: minimumNumberOfCharacters)
        }
    }
}
