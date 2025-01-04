struct CustomDatePicker: DatePickerStyle {
    @Binding var isFull: Bool
    @State private var sizeH: CGFloat = .zero
    
    private var days: [Days] {
        let calendar = Calendar.current
        let formatter = Date.FormatStyle()
            .weekday(.narrow)
            .locale(.current)
        let fullDay = Date.FormatStyle()
            .weekday(.wide)
            .locale(.current)
        
        return (2...8).compactMap { weekdayIndex -> Days? in
            let dateComponents = DateComponents(weekday: weekdayIndex)
            if let date = calendar.date(from: dateComponents) {
                return .init(fullDay: fullDay.format(date), formattedDay: formatter.format(date))
            }
            return nil
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    ForEach(days) { day in
                        Text(day.formattedDay)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                ScrollViewReader { value in
                    ScrollView {
                        let dates = generateDates(for: configuration.selection)
                        LazyVGrid(
                            columns: Array(
                                repeating: GridItem(.flexible(), spacing: 0),
                                count: 7
                            ),
                            alignment: .listRowSeparatorLeading,
                            spacing: 0
                        ) {
                            ForEach(dates, id: \.self) { date in
                                VStack {
                                    Text(date.get(.day) == 1 ? date.getMonth(.short) : "")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                    
                                    //                                    if date.get(.day) == 1 {
                                    //                                        Text(date.getMonth(.short))
                                    //                                            .font(.caption2)
                                    //                                    }
                                    Text(dateText(for: date))
                                        .font(.headline)
                                    Spacer()
                                }
                                .padding()
                                .background(
                                    date.normalizedDate() == configuration.selection.normalizedDate()
                                    ? Color.blue.opacity(0.4)
                                    : (date.normalizedDate() == Date().normalizedDate()
                                       ? Color.gray.opacity(0.3)
                                       : Color.clear)
                                )
                                //                                .foregroundColor(date.isInSameMonth(as: configuration.selection) ? .primary : .gray)
                                .clipShape(Circle())
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                                .onTapGesture {
                                    withAnimation {
                                        configuration.selection = date
                                        value.scrollTo(
                                            date,
                                            anchor: .center
                                        )
                                    }
                                }
                                .background(
                                    date
                                        .get(.month) % 2 == 0 ? Color.gray
                                        .opacity(0.4) : Color.clear
                                )
                            }
                        }
                        .onAppear {
                            withAnimation {
                                value.scrollTo(
                                    configuration.selection.normalizedDate(),
                                    anchor: .center
                                )
                            }
                        }
                        .onChange(of: isFull) { isOn in
                            if !isOn {
                                sizeH = .zero
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation {
                                    value.scrollTo(
                                        configuration.selection.normalizedDate(),
                                        anchor: .center
                                    )
                                }
                            }
                        }
                        .onChange(of: configuration.selection) { selection in
                            withAnimation {
                                value.scrollTo(
                                    selection,
                                    anchor: .center
                                )
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .contentMargins(0, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    .frame(height: (isFull ? 500 : 70) + sizeH)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            HStack {
                Spacer()
                Capsule()
                    .fill(.secondary)
                    .frame(width: 40, height: 5)
                Spacer()
            }
            .padding([.top, .horizontal])
            .padding(.bottom, 10)
            .background(.principal)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            if (value.translation.height > 0 && value.translation.height < 550) || (value.translation.height < 0 && value.translation.height > -550) {
                                sizeH = value.translation.height
                            }
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            sizeH = .zero
                            if (value.translation.height > 100 && !isFull) || (value.translation.height < -100 && isFull) {
                                isFull.toggle()
                            }
                        }
                    }
            )
        }
        .background(
            Color.principal
                .shadow(radius: 5, x: 0, y: 2)
                .ignoresSafeArea()
        )
    }
    
    private func getDateRange(for configuration: Configuration) -> [DateModel] {
        let minimumDate = Calendar.current.date(byAdding: .month, value: -2, to: Date())!
        let maximumDate = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
        
        var dates: [DateModel] = []
        var currentDate = minimumDate
        while currentDate <= maximumDate {
            dates
                .append(
                    .init(
                        day: .init(
                            fullDay: currentDate.getDay(.wide),
                            formattedDay: currentDate.getDay()
                        ),
                        date: currentDate
                    )
                )
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    private func generateDates(for date: Date) -> [Date] {
        
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
    
    private func dateText(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date).capitalized
    }
}