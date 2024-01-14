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
    var markedMoviesPublisher: PassthroughSubject<Set<MovieVM.ID>, Never> { get }
    func fetchMovies() async throws -> [MovieVM]
    func updateMarks(by movie: MovieVM)
}

final class MovieServices: MovieServicesProtocol {
    static let shared = MovieServices()
    
    let markedMoviesPublisher = PassthroughSubject<Set<MovieVM.ID>, Never>()
    
    private let repository: MovieRepository
    private let formatter: ListFormatter
    private var markedMovies = Set<MovieVM.ID>()
    
    init(repository: MovieRepository = MovieData.createRepository(APIKey: APIkey),
         formatter: ListFormatter = ListFormatter()) {
        self.repository = repository
        self.formatter = formatter
    }
    
    func fetchMovies() async throws -> [MovieVM] {
        let genres = try await repository.fetchGenres()
        let movies = try await repository.fetchPopularMovies()

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
        markedMoviesPublisher.send(markedMovies)
    }
    
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
