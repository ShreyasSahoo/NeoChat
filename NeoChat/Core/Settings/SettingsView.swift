//
//  SettingsView.swift
//  NeoChat
//
//  Created by Shreyas on 24/10/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignOutTapped()
                } label: {
                    Text("Sign out")
                }
            }
            .navigationTitle("Settings")
        }
    }

    private func onSignOutTapped() {
        // more logic to sign out the user
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            appState.updateViewState(false)
        })
    }
}

#Preview {
    SettingsView()
}
