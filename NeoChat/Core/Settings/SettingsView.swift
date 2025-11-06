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

    @State private var isPremium: Bool = true
    @State private var isAnonymousUser: Bool = true
    @State private var showCreateAccountView: Bool = false

    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
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
                    onSignOutTapped()
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
        // more logic to sign out the user
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            appState.updateViewState(false)
        })
    }

    private func onCreateAccountTapped() {
        showCreateAccountView = true
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

#Preview {
    SettingsView()
        .environment(AppState())
}
