//
//  Movie.swift
//  BeScared
//
//  Created by Joel Lacerda on 28/01/26.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    var fullPosterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var formattedDate: String {
        guard let dateString = releaseDate else { return "Unknown date" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            outputFormatter.locale = Locale(identifier: "eng_US")
            return outputFormatter.string(from: date)
        }
        
        return dateString
    }
    
    static let dummy = Movie(
            id: 0,
            title: "Name of the Horror Movie",
            posterPath: nil,
            overview: "This synopsis serves only to create gray lines on the screen while it loads.",
            voteAverage: 10.0,
            releaseDate: "2026-01-01"
        )
}
