//
//  Movie.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

public struct Movie: Decodable {
    public let id: Int
    public let title: String
    public let overview: String
    public let genreIds: [Int]
    public let voteAverage: Float
    let posterPath: String
    
    public var smallImageLink: String {
        "https://image.tmdb.org/t/p/w185/\(posterPath)"
    }
    
    public var largeImageLink: String {
        "https://image.tmdb.org/t/p/w500/\(posterPath)"
    }
    
    public init(id: Int, title: String, overview: String, genreIds: [Int], voteAverage: Float, posterPath: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.genreIds = genreIds
        self.voteAverage = voteAverage
        self.posterPath = posterPath
    }
}
