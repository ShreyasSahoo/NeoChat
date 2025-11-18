//
//  AppView.swift
//  NeoChat
//
//  Created by Shreyas on 22/10/25.
//

import SwiftUI

struct AppView: View {
    
    @State var appState: AppState = .init()
    @Environment(AuthManager.self) var authManager
    @Environment(UserManager.self) var userManager

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
        if let user = authManager.auth {
            // User is authenticated
            print("User already authenticated: \(user.uid)")

            do {
                try userManager.logIn(auth: user, isNewUser: false)
            } catch {
                print("Failed to login to auth for existing user: \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        } else {
            // User is not authenticated
            do {
                let result = try await authManager.signInAnonymously()

            // log in to app
                print("Signed in anonymously: \(result.user.uid)")

            //Login
                try userManager.logIn(auth: result.user, isNewUser: true)

            } catch {
                print("Failed to sign in anonymously and login: \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
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
