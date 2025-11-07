//
//  OnboardingCompletedView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct OnboardingCompletedView: View {

    @Environment(AppState.self) private var root

    @State private var isCompleteingProfileSetup: Bool = false
    var selectedColor: Color = .orange

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Setup complete!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(selectedColor)

                Text("We've set up your profile and you're ready to start chatting.")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)

            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                AsyncCallToActionButton(
                    isLoading: isCompleteingProfileSetup,
                    title: "Finish",
                    action: onFinishButtonTapped
                )
            }
            .padding(24)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private func onFinishButtonTapped() {
        // More logic to complete onboarding
        isCompleteingProfileSetup = true
        Task {
            try await Task.sleep(for: .seconds(2))
            isCompleteingProfileSetup = false
        }

        root.updateViewState(true)
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: .teal)
        .environment(AppState())
}
