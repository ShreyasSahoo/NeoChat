//
//  ContentView.swift
//  NeoChat
//
//  Created by Shreyas on 22/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            AppView(showTabBar: true)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
