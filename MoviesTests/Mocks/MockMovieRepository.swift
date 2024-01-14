//
//  MockMovieRepository.swift
//  MoviesTests
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import MovieData

final class MockMovieRepository: MovieRepository {
    private(set) var fetchTrendingMoviesCallCount = 0
    private(set) var fetchGenresCallCount = 0

    var expectedTrendingMoviesResult = [Movie]()
    var expectedFetchGenres = [Int : String]()
    
    func fetchTrendingMovies() async throws -> [Movie] {
        fetchTrendingMoviesCallCount += 1
        return expectedTrendingMoviesResult
    }
    
    func fetchGenres() async throws -> [Int : String] {
        fetchGenresCallCount += 1
        return expectedFetchGenres
    }
}
