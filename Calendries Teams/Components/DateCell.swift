//
//  DateCell.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 4/1/2025.
//

import SwiftUI

struct DateCell: View {
    let date: Date
    let configuration: CustomDatePicker.Configuration
    
    private var backround: Color {
        date.normalizedDate() == configuration.selection.normalizedDate()
        ? Color.blue.opacity(0.4)
        :
        (date.normalizedDate() == Date().normalizedDate()
           ? Color.gray.opacity(0.3)
           : Color.clear)
    }

    var body: some View {
        VStack {
            Text(date.get(.day) == 1 ? date.getMonth(.short) : "")
                .font(.caption2)
                .foregroundStyle(.secondary)
            
            Text(date.dateText())
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(backround)
        .overlay(
            Circle()
                .stroke(
                    date.normalizedDate() == configuration.selection.normalizedDate()
                    ? Color.blue
                    : Color.clear,
                    lineWidth: 2
                )
        )
        .background(
            date.get(.month) % 2 == 0
            ? Color.gray.opacity(0.4)
            : Color.clear
        )
        .clipShape(Circle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            withAnimation {
                configuration.selection = date
            }
        }
    }
}
