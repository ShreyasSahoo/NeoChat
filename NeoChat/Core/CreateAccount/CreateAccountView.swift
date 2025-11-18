//
//  CreateAccountView.swift
//  NeoChat
//
//  Created by Shreyas on 06/11/25.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {

    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss

    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account."
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?

    var body: some View {
        VStack(spacing: 28) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SignInWithAppleButtonView(
                type: .signUp,
                style: .black, cornerRadius: 10)
                .frame(height: 55)
                .anyButton(.press) {
                    onSignInApplePressed()
                }

            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
    }

    private func onSignInApplePressed() {
        Task {
            do {
                let result = try await authService.signInWithApple()

                print("Did signin with Apple!")
                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
