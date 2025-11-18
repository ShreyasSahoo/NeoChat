//
//  AnyAppAlert.swift
//  NeoChat
//
//  Created by Shreyas on 15/11/25.
//

import SwiftUI

struct AnyAppAlert {
    var title: String
    var subtitle: String?
    var buttons: @Sendable () -> AnyView

    init(
        title: String,
        subtitle: String? = nil,
        buttons: (@Sendable () -> AnyView)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK", action: {

                })
            )
        }
    }

    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
}

enum AlertType {
    case alert, confirmationDialog
}

extension View {
    @ViewBuilder
    func showCustomAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {
        switch type {
        case .alert:
            self
                .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert), actions: {
                    if let buttons = alert.wrappedValue?.buttons {
                        buttons()
                    }
                }, message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                })
        case .confirmationDialog:
            self
                .confirmationDialog("", isPresented: Binding(ifNotNil: alert)) {
                    if let buttons = alert.wrappedValue?.buttons {
                        buttons()
                    }
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        }
    }
}
