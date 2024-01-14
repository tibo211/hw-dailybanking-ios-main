//
//  MovieServices.swift
//  Movies
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import MovieData
import Foundation

final class MovieServices {
    let repository: MovieRepository
    
    init(repository: MovieRepository = MovieData.createRepository(APIKey: APIkey)) {
        self.repository = repository
    }
    
    func fetchMovies() async throws -> [MovieVM] {
        let genres = try await repository.fetchGenres()
        let movies = try await repository.fetchPopularMovies()

        return movies
            .map { movie in convert(movie: movie, genres: genres) }
    }
    
    func convert(movie: Movie, genres: [Int : String]) -> MovieVM {
        let genres = movie.genreIds.compactMap { genres[$0] }

        return MovieVM(
            id: String(movie.id),
            title: movie.title,
            genres: ListFormatter().string(from: genres) ?? "",
            overView: movie.overview,
            image: .init(small: movie.smallImageLink,
                         large: movie.largeImageLink),
            popularity: movie.popularity,
            isMarked: false
        )
    }
}
