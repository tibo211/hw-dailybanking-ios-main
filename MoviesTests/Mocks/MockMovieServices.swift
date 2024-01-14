//
//  MockMovieServices.swift
//  MoviesTests
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import Foundation
import Combine
@testable import Movies

final class MockMovieServices: MovieServicesProtocol {
    @Published var expectedMarkedMovies = Set<MovieVM.ID>()
    
    var markedMoviesPublisher: AnyPublisher<Set<MovieVM.ID>, Never> {
        $expectedMarkedMovies.eraseToAnyPublisher()
    }
    
    var expectedFetchMoviesResults = [MovieVM]()
    private(set) var fetchMoviesCallCount = 0
    
    func fetchMovies() async throws -> [MovieVM] {
        fetchMoviesCallCount += 1
        return expectedFetchMoviesResults
    }
    
    func updateMarks(by movie: MovieVM) {}
}
