//
//  AsyncCallToActionButton.swift
//  NeoChat
//
//  Created by Shreyas on 07/11/25.
//

import SwiftUI

struct AsyncCallToActionButton: View {
    
    var isLoading: Bool = false
    var title: String = "Save"
    var action: () -> Void

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            action()
        }
        .disabled(isLoading)
    }
}

private struct PreviewView: View {
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            AsyncCallToActionButton(isLoading: isLoading, title: "Finish") {
                isLoading = true
                Task {
                    try? await Task.sleep(for: .seconds(2))
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    PreviewView()
        .padding()
}
