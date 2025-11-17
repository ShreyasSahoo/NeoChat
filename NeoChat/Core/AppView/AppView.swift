//
//  AppView.swift
//  NeoChat
//
//  Created by Shreyas on 22/10/25.
//

import SwiftUI
import Firebase

struct AppView: View {
    
    @State var appState: AppState = .init()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

#Preview("AppView -- Tabbar"){
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView -- Onboarding"){
    AppView(appState: AppState(showTabBar: false))
}
