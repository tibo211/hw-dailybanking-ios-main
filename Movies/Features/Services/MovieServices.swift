//
//  MovieServices.swift
//  Movies
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import MovieData

final class MovieServices {
    let repository: MovieRepository
    
    init(repository: MovieRepository = MovieData.createRepository(APIKey: APIkey)) {
        self.repository = repository
    }
    
    func fetchMovies() async throws -> [MovieVM] {
        let movies = try await repository.fetchMovies()
        return []
    }
}
