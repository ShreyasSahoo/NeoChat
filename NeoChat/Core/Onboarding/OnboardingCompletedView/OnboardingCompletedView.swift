//
//  OnboardingCompletedView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct OnboardingCompletedView: View {

    @Environment(AppState.self) private var root
    @Environment(UserManager.self) private var userManager

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
        isCompleteingProfileSetup = true
        
        Task {
            let hex = selectedColor.asHex()
            do {
                try await userManager.markOnboardingCompletedForCurrentUser(profileColorHex: hex)
            } catch {
                print("ERROR: \(error)")
            }
            isCompleteingProfileSetup = false
            root.updateViewState(true)
        }
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: .teal)
        .environment(AppState())
        .environment(UserManager(services: MockUserServices(user: .mock)))
}
