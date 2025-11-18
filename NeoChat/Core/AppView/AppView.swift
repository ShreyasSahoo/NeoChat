//
//  AppView.swift
//  NeoChat
//
//  Created by Shreyas on 22/10/25.
//

import SwiftUI

struct AppView: View {
    
    @State var appState: AppState = .init()
    @Environment(\.authService) var authService

    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            })
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, newValue in
            if !newValue {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }

    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            // User is authenticated
            print("User already authenticated: \(user.uid)")
        } else {
            // User is not authenticated
            do {
                let result = try await authService.signInAnonymously()

            // log in to app
                print("Signed in anonymously: \(result.user.uid)")
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
}

#Preview("AppView -- Tabbar"){
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView -- Onboarding"){
    AppView(appState: AppState(showTabBar: false))
}
