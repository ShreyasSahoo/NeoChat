//
//  WelcomeView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageURL: String = Constants.randomImageURL

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
                    print("Printed")
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
}

#Preview {
    WelcomeView()
}
