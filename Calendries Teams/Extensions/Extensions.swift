//
//  Extensions.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 3/1/2025.
//

import SwiftUI

extension DatePickerStyle where Self == CustomDatePicker {
    static func custom(isFull: Binding<Bool>) -> CustomDatePicker {
        CustomDatePicker(isFull: isFull)
    }
}

extension Date {
    var weekday: Int {
        Calendar.current.component(.weekday, from: self) - 1
    }

    func isInSameMonth(as date: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        calendar.component(component, from: self)
    }
    
    func getDay(_ type: Date.FormatStyle.Symbol.Weekday = .narrow) -> String {
        self.formatted(Date.FormatStyle().weekday(type))
    }
    
    func getMonth(_ type: Date.FormatStyle.Symbol.Weekday = .narrow) -> String {
        self.formatted(.dateTime.weekday(type))
    }
    
    func normalizedDate() -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    
    func dateText() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    func monthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self).capitalized
    }
}
