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
        return movies
            .map { movie in convert(movie: movie) }
    }
    
    func convert(movie: Movie) -> MovieVM {
        MovieVM(
            id: String(movie.id),
            title: movie.title,
            genres: "",
            overView: movie.overview,
            image: .init(small: movie.smallImageLink,
                         large: movie.largeImageLink),
            popularity: movie.popularity,
            isMarked: false
        )
    }
}
