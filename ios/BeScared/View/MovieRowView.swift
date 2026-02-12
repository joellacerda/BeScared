//
//  MovieRowView.swift
//  BeScared
//
//  Created by Joel Lacerda on 28/01/26.
//

import SwiftUI

struct MovieRowView: View {
    var movie: Movie
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: movie.fullPosterURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 80, height: 120)
            .cornerRadius(12)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("•")
                        .foregroundColor(.gray)
                    
                    Text(movie.releaseDate?.prefix(4) ?? "N/A")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.5))
        }
        
        .padding(12)
        .background(Color(white: 0.1))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}
