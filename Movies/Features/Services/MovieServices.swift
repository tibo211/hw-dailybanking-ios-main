//
//  MovieServices.swift
//  Movies
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import MovieData
import Foundation
import Combine

protocol MovieServicesProtocol {
    /// Publishes a set of movie ids every time a movie was marked or the mark was removed.
    var markedMoviesPublisher: AnyPublisher<Set<MovieVM.ID>, Never> { get }
    
    /// Fetches the list of genres and the popular movies, then creates the movie list from the results.
    /// - Returns: Popular movies.
    func fetchMovies() async throws -> [MovieVM]

    /// Notifies the marked movie set that the given  movie was updated.
    /// - Parameter movie: `MovieVM` with updated `isMarked` property.
    func updateMarks(by movie: MovieVM)
}

final class MovieServices: MovieServicesProtocol {
    static let shared = MovieServices()
    
    var markedMoviesPublisher: AnyPublisher<Set<MovieVM.ID>, Never> {
        $markedMovies.eraseToAnyPublisher()
    }
    
    private let repository: MovieRepository
    private let formatter: ListFormatter
    @Published private var markedMovies = Set<MovieVM.ID>()
    
    init(repository: MovieRepository = MovieData.createRepository(APIKey: APIkey),
         formatter: ListFormatter = ListFormatter()) {
        self.repository = repository
        self.formatter = formatter
    }
    
    func fetchMovies() async throws -> [MovieVM] {
        let genres = try await repository.fetchGenres()
        let movies = try await repository.fetchTrendingMovies()

        return movies
            .map { movie in
                convert(movie: movie, genres: genres)
            }
    }
    
    func updateMarks(by movie: MovieVM) {
        if movie.isMarked {
            markedMovies.insert(movie.id)
        } else {
            markedMovies.remove(movie.id)
        }
    }
}

private extension MovieServices {
    func convert(movie: Movie, genres: [Int : String]) -> MovieVM {
        let genres = movie.genreIds.compactMap { genres[$0] }

        return MovieVM(
            id: String(movie.id),
            title: movie.title,
            genres: formatter.string(from: genres) ?? "",
            overView: movie.overview,
            image: .init(small: movie.smallImageLink,
                         large: movie.largeImageLink),
            popularity: movie.voteAverage,
            isMarked: false
        )
    }
}
