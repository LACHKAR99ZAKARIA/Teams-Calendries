//
//  CenterDatePicker.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 4/1/2025.
//

import SwiftUI

struct CenterDatePicker: DatePickerStyle {
    @Binding var isFull: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ScrollViewReader { value in
            ScrollView {
                VStack {
                    let dates = generateDates(for: configuration.selection)
                    ForEach(dates, id: \.self) { date in
                        VStack {
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .font(.system(size: 20, weight: .semibold))
                                .padding()
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .background(Color.blue.opacity(0.2))
                            ScrollView {
                                
                            }
                        }
                    }
                }
            }
            .onScrollPhaseChange { oldPhase, newPhase in
                if newPhase == .interacting {
                    withAnimation {
                        isFull = false
                    }
                }
            }
            .onChange(of: configuration.selection) { selection in
                scrollToSelection(value, configuration.selection)
            }
        }
    }
    
    func generateDates(for date: Date) -> [Date] {
        
        guard let monthInterval = extendedMonthInterval(for: date) else {
            return []
        }
        
        let startDate = monthInterval.start
        let endDate = monthInterval.end
        
        var dates: [Date] = []
        var currentDate = Calendar.current.date(byAdding: .day, value: -startDate.weekday, to: startDate) ?? startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return dates
    }
    
    func extendedMonthInterval(for date: Date) -> DateInterval? {
        let calendar = Calendar.current
        
        guard let currentMonthInterval = calendar.dateInterval(of: .month, for: Date()) else {
            return nil
        }
        
        guard let startDate = calendar.date(byAdding: .month, value: -2, to: currentMonthInterval.start) else { return nil }
        
        guard let endDate = calendar.date(byAdding: .month, value: 2, to: currentMonthInterval.end) else { return nil }
        
        return DateInterval(start: startDate, end: endDate)
    }
    
    func scrollToSelection(_ value: ScrollViewProxy, _ selection: Date) {
        DispatchQueue.main.async {
            withAnimation {
                value.scrollTo(selection, anchor: .top)
            }
        }
    }
}
