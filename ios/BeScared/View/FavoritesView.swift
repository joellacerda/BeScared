//
//  FavoritesView.swift
//  BeScared
//
//  Created by Joel Lacerda on 30/01/26.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    @State private var favorites: [Movie] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if favorites.isEmpty {
                    ContentUnavailableView(
                        "No Nightmares Yet",
                        systemImage: "moon.zzz.fill",
                        description: Text("Save movies to build your horror collection.")
                    )
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(favorites) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieRowView(movie: movie)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .background(Color.black)
            .navigationTitle("My Collection ⚰️")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
            .onAppear {
                Task {
                    favorites = await viewModel.fetchFavoriteMoviesList()
                }
            }
        }
    }
}
