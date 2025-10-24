//
//  IntroView.swift
//  NeoChat
//
//  Created by Shreyas on 24/10/25.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        VStack {
            Group {
                Text("Make your own ")
                +
                Text("avatars")
                    .foregroundStyle(Color(.accent))
                    .fontWeight(.semibold)
                +
                Text(" and chat with them!\n\nHave ")
                +
                Text("real conversations")
                    .foregroundStyle(Color(.accent))
                    .fontWeight(.semibold)
                +
                Text(" with AI generated responses.")
            }
            .padding(24)
            .baselineOffset(6)
            .frame(maxHeight: .infinity)

            NavigationLink {
                OnboardingColorView()
            } label: {
                Text("Continue")
                    .callToActionButton()
            }
        }
        .padding(24)
    }
}

#Preview {
    IntroView()
}
