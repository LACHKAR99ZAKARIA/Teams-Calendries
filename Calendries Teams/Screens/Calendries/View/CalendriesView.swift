//
//  CalendriesView.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 2/1/2025.
//

import SwiftUI

struct CalendriesView: View {
    @StateObject private var viewModel = CalendriesViewModel()
    @State private var scrollOffset: CGFloat = 0.0
    
    var body: some View {
        DatePicker("Date", selection: $viewModel.pickedDate)
            .datePickerStyle(.center(isFull: $viewModel.isFull))
            .safeAreaInset(edge: .top) {
                DatePicker("Date", selection: $viewModel.pickedDate)
                    .datePickerStyle(.dragable(isFull: $viewModel.isFull))
            }
    }
    
    func scrollToSelection(_ value: ScrollViewProxy, _ selection: Date) {
        DispatchQueue.main.async {
            withAnimation {
                value.scrollTo(selection, anchor: .center)
            }
        }
    }
}

#Preview {
    CalendriesView()
}
