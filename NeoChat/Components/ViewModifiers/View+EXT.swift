//
//  View+EXT.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

extension View {
    
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.accent)
            .cornerRadius(16)
    }

    func removeListFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }

    func addBackgroundGradientForText() -> some View {
        background {
            LinearGradient(colors: [.black.opacity(0), .black.opacity(0.3), .black.opacity(0.4)], startPoint: .top, endPoint: .bottom)
        }
    }

    func badgeButton() -> some View {
        self
            .font(.caption.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.blue)
            .cornerRadius(8)
    }
}
