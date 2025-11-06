//
//  Date+EXT.swift
//  NeoChat
//
//  Created by Shreyas on 04/11/25.
//

import Foundation

extension Date {
    func adding(days: Int = 0, hours: Int = 0, minutes: Int = 0) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        dateComponents.hour = hours
        dateComponents.minute = minutes
        return Calendar.current.date(byAdding: dateComponents, to: self) ?? self
    }
}
