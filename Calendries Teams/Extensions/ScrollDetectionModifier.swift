//
//  ScrollDetectionModifier.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 4/1/2025.
//


import SwiftUI

struct ScrollDetectionModifier: ViewModifier {
    let onScroll: (CGFloat) -> Void

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        let initialOffset = geometry.frame(in: .global).minY
                        onScroll(initialOffset)
                    }
                    .onChange(of: geometry.frame(in: .global).minY) { newValue in
                        onScroll(newValue)
                    }
            })
    }
}

extension View {
    func onScroll(_ onScroll: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(ScrollDetectionModifier(onScroll: onScroll))
    }
}
