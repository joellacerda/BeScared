//
//  LikeButton.swift
//  BeScared
//
//  Created by Joel Lacerda on 30/01/26.
//

import SwiftUI

struct LikeButton: View {
    var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
            action()
        } label: {
            HStack {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 20, weight: .bold))
                    .scaleEffect(isFavorite ? 1.2 : 1.0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isFavorite)
                
                Text(isFavorite ? "Liked" : "Like")
                    .fontWeight(.semibold)
                    .contentTransition(.numericText())
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .buttonStyle(.borderedProminent)
        .tint(isFavorite ? .red : .gray.opacity(0.5))
        .animation(.easeInOut(duration: 0.2), value: isFavorite)
    }
}
