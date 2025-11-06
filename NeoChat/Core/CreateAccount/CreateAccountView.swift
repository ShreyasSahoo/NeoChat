//
//  CreateAccountView.swift
//  NeoChat
//
//  Created by Shreyas on 06/11/25.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account."


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

                }

            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
    }
}

#Preview {
    CreateAccountView()
}
