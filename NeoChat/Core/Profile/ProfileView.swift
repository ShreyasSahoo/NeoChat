//
//  ProfileView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    private var settingsButton: some View {
        Button {
            onSettingsButtonTapped()
        } label: {
            Image(systemName: "gear")
                .font(.headline)
        }
    }
    
    private func onSettingsButtonTapped() {
        showSettings = true
    }
}

#Preview {
    ProfileView()
}
