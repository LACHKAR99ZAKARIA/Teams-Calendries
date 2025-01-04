//
//  CalendriesView.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 2/1/2025.
//

import SwiftUI

struct CalendriesView: View {
    @StateObject private var viewModel = CalendriesViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
        .safeAreaInset(edge: .top) {
            header
        }
    }
    
    var header: some View {
        VStack(spacing: 0) {
            HStack {
                
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    CalendriesView()
}
