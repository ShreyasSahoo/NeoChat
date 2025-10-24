//
//  AppView.swift
//  NeoChat
//
//  Created by Shreyas on 22/10/25.
//

import SwiftUI

struct AppView: View {
    
    @State var appState: AppState = .init()
    
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

#Preview("AppView -- Tabbar"){
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView -- Onboarding"){
    AppView(appState: AppState(showTabBar: false))
}
