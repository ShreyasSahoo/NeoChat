//
//  CarouselView.swift
//  NeoChat
//
//  Created by Shreyas on 26/10/25.
//

import SwiftUI

struct CarouselView<Content: View, T: Hashable>: View {

    var items: [T]
    @ViewBuilder var content: (T) -> Content
    @State private var selection: T?

    var body: some View {
        VStack(spacing: 8) {
            scrollView

            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(selection == item ? Color.accent : .secondary)
                        .frame(width: selection == item ? 10 : 8, height: selection == item ? 10 : 8)
                }
            }
        }
    }

    private var scrollView: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                        content(item)
                        .id(item)
                        .padding(16)
                        .containerRelativeFrame(.horizontal, alignment: .center)
                        .scrollTransition(.interactive.threshold(.visible(0.95))) { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .scrollPosition(id: $selection)
        .onAppear {
            updateSelectionIfNeeded()
        }
        .onChange(of: items.count) {
            updateSelectionIfNeeded()
        }
    }

    private func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}

#Preview {
    CarouselView(items: AvatarModel.mocks) { item in
        HeroCellView(
            title: item.name,
            subtitle: item.characterDescription,
            imageName: item.profileImageName
        )
    }
}
