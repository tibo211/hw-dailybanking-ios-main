//
//  MockMovieRepository.swift
//  MoviesTests
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import MovieData

final class MockMovieRepository: MovieRepository {
    private(set) var fetchPopularMoviesCallCount = 0
    private(set) var fetchGenresCallCount = 0

    var expectedPopularMoviesResult = [Movie]()
    var expectedFetchGenres = [Int : String]()
    
    func fetchPopularMovies() async throws -> [Movie] {
        fetchPopularMoviesCallCount += 1
        return expectedPopularMoviesResult
    }
    
    func fetchGenres() async throws -> [Int : String] {
        fetchGenresCallCount += 1
        return expectedFetchGenres
    }
}
