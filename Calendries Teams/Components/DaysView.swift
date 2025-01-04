//
//  DaysView 2.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 4/1/2025.
//


import SwiftUI

struct DaysView: View {
    let days: [Days]
    var body: some View {
        HStack {
            ForEach(days) { day in
                Text(day.formattedDay)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
    }
}
