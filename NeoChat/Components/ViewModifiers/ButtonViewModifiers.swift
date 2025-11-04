//
//  ButtonViewModifiers.swift
//  NeoChat
//
//  Created by Shreyas on 03/11/25.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.accentColor.opacity(0.4) : Color.accentColor.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtonStyleOption {
    case highlight, press, plain
}

extension View {
    @ViewBuilder
    func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .highlight:
            self.hightlightButton(action: action)
        case .press:
            self.pressableButton(action: action)
        case .plain:
            self.plainButton(action: action)
        }
    }

    private func hightlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }

    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }

    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack {
        Text("Button 1")
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .cornerRadius(10)
            .anyButton(.highlight) {
                print("highlight")
            }

        Text("Button 2")
            .callToActionButton()
            .anyButton(.press) {
                print("press")
            }
    }
    .padding()
}
