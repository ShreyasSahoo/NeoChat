//
//  Binding+EXT.swift
//  NeoChat
//
//  Created by Shreyas on 15/11/25.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {

    init<T>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
