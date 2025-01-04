import SwiftUI

struct ScrollDetectionModifier: ViewModifier {
    let onScroll: (CGFloat) -> Void

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        let initialOffset = geometry.frame(in: .global).minY
                        onScroll(initialOffset) // Capture initial position if needed
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
