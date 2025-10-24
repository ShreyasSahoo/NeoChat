//
//  OnboardingCompletedView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var root

    var body: some View {
        NavigationStack {
            VStack {
                Text("Onboarding Completed!")
                    .frame(maxHeight: .infinity)
                
                Button {
                    onFinishButtonTapped()
                } label: {
                    Text("Finish")
                        .callToActionButton()
                }
            }
            .padding(16)
        }
    }

    private func onFinishButtonTapped() {
        // More logic to complete onboarding
        root.updateViewState(true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState(showTabBar: false))
}
