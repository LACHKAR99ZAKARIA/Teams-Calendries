//
//  CalendriesViewModel.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 2/1/2025.
//

import SwiftUI

class CalendriesViewModel: ObservableObject {
    @Published var pickedDate: Date = Date()
    @Published var isFull: Bool = false
}

struct DateModel: Identifiable {
    var id = UUID()
    var day: Days
    var date: Date
}

struct Days: Identifiable {
    var id: String {
        fullDay
    }
    var fullDay: String
    var formattedDay: String
}

class LanguageSetting: ObservableObject {
    var locale = Locale(identifier: "en")
}
