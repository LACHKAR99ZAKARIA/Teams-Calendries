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
        ScrollView {
            VStack {
                ForEach(0..<50) { index in
                    Text("Item \(index)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                }
            }
        }
        .onScrollPhaseChange { oldPhase, newPhase in
            if newPhase == .interacting {
                withAnimation {
                    viewModel.isFull = false
                }
            }
        }
        
        //            .background(
        //                GeometryReader { geometry in
        //                    Color.clear
        //                        .onChange(of: geometry.frame (in: .global).minY) {
        //                            withAnimation {
        //                                print("i")
        //                                viewModel.isFull = false
        //                            }
        //                        }
        //                }
        //            )
        .safeAreaInset(edge: .top) {
            datePicker
        }
        //        .onScroll { offset in
        //            if viewModel.isFull == true {
        //                viewModel.isFull = false
        //            }
        //        }
    }
    
    var datePicker: some View {
        VStack(spacing: 0) {
            DatePicker("Date", selection: $viewModel.pickedDate)
                .datePickerStyle(.custom(isFull: $viewModel.isFull))
        }
    }
}

#Preview {
    CalendriesView()
}
