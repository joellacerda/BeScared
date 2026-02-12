//
//  ShimmerEffect.swift
//  BeScared
//
//  Created by Joel Lacerda on 29/01/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmering(active: Bool = true) -> some View {
        if active {
            self.modifier(ShimmerEffect())
        } else {
            self
        }
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var opacity: Double = 0.5
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    opacity = 1.0
                }
            }
    }
}
