//
//  MovieDetailsScreenViewModelTests.swift
//  MoviesTests
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import XCTest
@testable import Movies

final class MovieDetailsScreenViewModelTests: XCTestCase {
    func testMarkMovie_toggleMovie() {
        let services = MockMovieServices()
        let sut = MovieDetailsScreenViewModel(movie: exampleMovie,
                                              movieServices: services)
        
        sut.markMovie()
        
        XCTAssertTrue(sut.movie.isMarked)
        XCTAssertEqual(services.updateMarksCallCount, 1)
    }
}
