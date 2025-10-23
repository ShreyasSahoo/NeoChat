//
//  AppViewBuilder.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct AppViewBuilder<TabbarView: View, OnboardingView: View>: View {
    //    OLD VERBOSE WAY
    //    let tabbarView: TabbarView
    //    let onboardingView: OnboardingView
    //
    //    init(@ViewBuilder tabbarView: () -> TabbarView, @ViewBuilder onboardingView: () -> OnboardingView) {
    //        tabbarView = tabbarView()
    //        onboardingView = onboardingView()
    //    }
    
    // USE THIS INSTEAD
    var showTabBar: Bool = false
    @ViewBuilder var tabbarView: TabbarView
    @ViewBuilder var onboardingView: OnboardingView
    
    var body: some View {
        ZStack {
            if showTabBar {
                tabbarView
                    .transition(.move(edge: .trailing))
            } else {
                onboardingView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showTabBar)
    }
}
