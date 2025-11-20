//
//  SettingsView.swift
//  NeoChat
//
//  Created by Shreyas on 24/10/25.
//

import SwiftUI
import SwiftfulUtilities

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(AuthManager.self) var authManager
    @Environment(UserManager.self) var userManager

    @State private var isPremium: Bool = true
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false

    @State private var showAlert: AnyAppAlert?

    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
            .navigationTitle("Settings")
            .showCustomAlert(type: .confirmationDialog, alert: $showAlert)
            .sheet(isPresented: $showCreateAccountView, onDismiss: {
                checkUserAnonymityStatus()
            }, content: {
                CreateAccountView()
                    .presentationDetents([.medium])
            })
        }
        .onAppear {
            checkUserAnonymityStatus()
        }
    }

    private var accountSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save & back-up account")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onCreateAccountTapped()
                    }
                    .removeListFormatting()

            } else {
                Text("Sign out")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onSignOutTapped()
                    }
                    .removeListFormatting()
            }

            Text("Delete")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight) {
                    onDeleteAccountTapped()
                }
                .removeListFormatting()
        } header: {
            Text("ACCOUNT")
        }
    }

    private var purchaseSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Account Status: \(isPremium ? "PREMIUM" : "FREE")")
                Spacer(minLength: 0)

                if isPremium {
                    Text("MANAGE")
                        .badgeButton()
                }
            }
            .rowFormatting()
            .anyButton(.highlight) {

            }
            .disabled(!isPremium)
            .removeListFormatting()
        } header: {
            Text("PURCHASES")
        }
    }

    private var applicationSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListFormatting()

            HStack(spacing: 8) {
                Text(Utilities.buildNumber ?? "")
                Spacer(minLength: 0)

                Text("3")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListFormatting()

            Text("Contact us")
                .foregroundStyle(.blue)
                .rowFormatting()
                .removeListFormatting()
                .anyButton(.highlight) {

                }
        } header: {
            Text("APPLICATION")
        } footer: {
            Text("Created by Shreyas Sahoo.\nLearn more at https://shreyassahoo.com")
                .baselineOffset(6)
        }
    }

    private func onSignOutTapped() {
        Task {
            do {
                try authManager.signOut()
                userManager.signOut()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
            await dismissScreen()
        }
    }

    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appState.updateViewState(false)
    }

    private func onDeleteAccountTapped() {
        showAlert = .init(
            title: "Do you want to delete your account?",
            subtitle: "This action is permanent and cannot be reversed.",
            buttons: {
                AnyView(
                    Group {
                        Button(role: .destructive) {
                            onDeleteAccountConfirmed()
                        } label: {
                            Text("Delete Account")
                        }

                        Button(role: .cancel) {

                        } label: {
                            Text("Cancel")
                        }
                    }
                )
            }
        )
    }

    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authManager.deleteAccount()
                try await userManager.deleteCurrentUser()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
            await dismissScreen()
        }
    }

    private func onCreateAccountTapped() {
        showCreateAccountView = true
    }

    private func checkUserAnonymityStatus() {
        isAnonymousUser = authManager.auth?.isAnonymous ?? true
    }
}

fileprivate extension View {

    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .systemBackground))
    }
}

#Preview("Anonymous User") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(service: MockUserService(user: nil)))
        .environment(AppState())
}

#Preview("Signed IN User") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: .mock(isAnonymous: false))))
        .environment(UserManager(service: MockUserService(user: .mock)))
        .environment(AppState())
}

#Preview("No User") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: .mock(isAnonymous: true))))
        .environment(UserManager(service: MockUserService(user: .mock)))
        .environment(AppState())
}
