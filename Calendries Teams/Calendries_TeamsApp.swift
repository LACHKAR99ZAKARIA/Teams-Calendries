//
//  Calendries_TeamsApp.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 2/1/2025.
//

import SwiftUI

@main
struct Calendries_TeamsApp: App {
    @StateObject private var language = LanguageSetting()
    var body: some Scene {
        WindowGroup {
            CalendriesView()
                .environmentObject(language)
        }
    }
}
