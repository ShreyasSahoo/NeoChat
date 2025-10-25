//
//  OnboardingColorView.swift
//  NeoChat
//
//  Created by Shreyas on 24/10/25.
//

import SwiftUI

struct OnboardingColorView: View {
    let colors: [Color] = [.red, .blue, .yellow, .green, .purple, .pink, .orange, .brown, .gray, .black, .indigo, .mint, .teal, .cyan, .accent, .primary]
    @State private var selectedColor: Color?

    var body: some View {
        ScrollView {
            colorGrid
            .padding(.horizontal, 24)
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 16, content: {
            ZStack {
                if let selectedColor {
                    ctaButton(selectedColor: selectedColor)
                    .transition(.move(edge: .bottom))
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 24)
            .background(Color(uiColor: UIColor.systemBackground))

        })
        .toolbar(.hidden, for: .navigationBar)
        .animation(.bouncy, value: selectedColor)

    }

    private var colorGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
            alignment: .center,
            spacing: 16,
            pinnedViews: [.sectionHeaders],
            content: {
                Section(content: {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(.accent)
                            .overlay(
                                Color(color)
                                    .clipShape(Circle())
                                    .padding(selectedColor == color ? 10 : 0)
                            )
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }, header: {
                    Text("Select a profile color")
                        .font(.headline)
                })
            }
        )
    }

    private func ctaButton(selectedColor: Color) -> some View {
        NavigationLink {
            OnboardingCompletedView(selectedColor: selectedColor)
        } label: {
            Text("Continue")
                .callToActionButton()
        }

    }
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
    .environment(AppState())

}
