//
//  WelcomeView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageURL: String = Constants.randomImageURL
    @State private var showSignInHalfCard: Bool = false
    @Environment(AppState.self) private var root

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                ImageLoaderView(urlString: imageURL)
                    .ignoresSafeArea()

                titleSection

                buttonSection

                linksSection

            }
        }
        .sheet(isPresented: $showSignInHalfCard) {
            CreateAccountView(
                title: "Sign in",
                subtitle: "Connect to an existing account.",
                onDidSignIn: { isNewUser in
                    handleDidSignIn(isNewUser: isNewUser)
                }
            )
                .presentationDetents([.medium])
        }
    }

    private var titleSection: some View {
        VStack {
            Text("NeoChat")
                .font(Font.largeTitle.bold())
            Text("This is the new experience")
                .font(Font.body)
                .foregroundStyle(Color(.secondaryLabel))
        }
    }

    private var buttonSection: some View {
        VStack {
            NavigationLink {
                IntroView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            .padding(.horizontal, 16)

            Text("Already have an account? Sign in!")
                .underline(true)
                .padding(28)
                .background(.black.opacity(0.01))
                .onTapGesture {
                    onSignInTapped()
                }
        }
    }

    private var linksSection: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termsOfServiceURL)!) {
                Text("Terms of Service")
            }

            Circle()
                .frame(width: 4, height: 4)

            Link(destination: URL(string: Constants.privacyPolicyURL)!) {
                Text("Privacy Policy")
            }
        }
        .foregroundStyle(.accent)
    }

    private func onSignInTapped() {
        showSignInHalfCard = true
    }

    private func handleDidSignIn(isNewUser: Bool) {
        if !isNewUser {
            root.updateViewState(true)
        }
    }
}

#Preview {
    WelcomeView()
        .environment(AppState())
}
