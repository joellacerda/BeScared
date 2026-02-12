//
//  MoviesViewModel.swift
//  BeScared
//
//  Created by Joel Lacerda on 28/01/26.
//

import Combine
import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var favoriteIds: Set<Int> = []
    
    private let baseURL = "http://10.0.1.113:8080/api/movies"
    
    func fetchMovies() async {
        self.isLoading = true
        guard let url = URL(string: "\(baseURL)/horror") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Movie].self, from: data)
            self.movies = decoded
        } catch {
            print("Erro movies: \(error)")
        }
        isLoading = false
    }
    
    func fetchFavoriteIds() async {
        guard let url = URL(string: "\(baseURL)/favorites") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let favorites = try JSONDecoder().decode([Movie].self, from: data)
            self.favoriteIds = Set(favorites.map { $0.id })
        } catch {
            print("Erro favorites: \(error)")
        }
    }
    
    func fetchFavoriteMoviesList() async -> [Movie] {
        guard let url = URL(string: "\(baseURL)/favorites") else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let favorites = try JSONDecoder().decode([Movie].self, from: data)
            return favorites
        } catch {
            print("Erro ao buscar lista de favoritos: \(error)")
            return []
        }
    }
    
    func toggleFavorite(movie: Movie) async {
        if favoriteIds.contains(movie.id) {
            await removeFavorite(id: movie.id)
        } else {
            await saveFavorite(movie: movie)
        }
    }
    
    private func saveFavorite(movie: Movie) async {
        guard let url = URL(string: "\(baseURL)/favorites") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(movie)
            request.httpBody = jsonData
            let (_, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                favoriteIds.insert(movie.id)
                print("❤️ Favoritado!")
            }
        } catch { print(error) }
    }
    
    private func removeFavorite(id: Int) async {
        guard let url = URL(string: "\(baseURL)/favorites/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
                favoriteIds.remove(id)
                print("💔 Removido!")
            }
        } catch { print(error) }
    }
}
