//
//  ScrollOffsetKey.swift
//  Calendries Teams
//
//  Created by Zakaria Lachkar on 4/1/2025.
//

import SwiftUI

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollOffsetDetector: View {
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: ScrollOffsetKey.self, value: proxy.frame(in: .global).minY)
        }
    }
}
