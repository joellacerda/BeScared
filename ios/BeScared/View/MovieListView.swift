//
//  MovieListView.swift
//  BeScared
//
//  Created by Joel Lacerda on 28/01/26.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if viewModel.isLoading {
                        ForEach(0..<6, id: \.self) { _ in
                            MovieRowView(movie: Movie.dummy)
                                .redacted(reason: .placeholder)
                                .shimmering()
                        }
                    } else {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieRowView(movie: movie)
                            }
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .background(Color.black)
            .navigationTitle("BeScared! 👻")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
            .onAppear {
                Task {
                    await viewModel.fetchMovies()
                }
            }
        }
    }
}

#Preview {
    MovieListView()
}
