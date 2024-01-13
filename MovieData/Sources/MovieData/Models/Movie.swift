//
//  Movie.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

public struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let genreIds: [Int]
    let posterPath: String
    let popularity: Double
    
    var smallImageLink: String {
        "https://image.tmdb.org/t/p/w185/\(posterPath)"
    }
    
    var largeImageLink: String {
        "https://image.tmdb.org/t/p/w500/\(posterPath)"
    }
}
