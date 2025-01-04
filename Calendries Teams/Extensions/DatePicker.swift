//
//  Extensions.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 3/1/2025.
//

import SwiftUI

extension DatePickerStyle where Self == DragableDatePicker {
    static func dragable(isFull: Binding<Bool>) -> DragableDatePicker {
        DragableDatePicker(isFull: isFull)
    }
}

extension DatePickerStyle where Self == CenterDatePicker {
    static func center(isFull: Binding<Bool>) -> CenterDatePicker {
        CenterDatePicker(isFull: isFull)
    }
}
