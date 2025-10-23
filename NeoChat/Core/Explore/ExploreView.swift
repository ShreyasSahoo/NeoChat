//
//  ExploreView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Explore")
                NavigationLink("Click Here") {
                    Text("New Screen")
                }
            }
                .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
