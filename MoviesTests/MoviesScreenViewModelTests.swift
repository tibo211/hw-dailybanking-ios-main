//
//  MoviesScreenViewModelTests.swift
//  MoviesTests
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import XCTest
@testable import Movies

final class MoviesScreenViewModelTests: XCTestCase {
    private let services = MockMovieServices()
    private var sut: MoviesScreenViewModel!
    
    override func setUp() {
        sut = MoviesScreenViewModel(movieServices: services)
    }
    
    func testFetchMovies_updatesMovies() async {
        services.expectedFetchMoviesResults = [exampleMovie]
        
        await sut.fetchMovies()
        
        XCTAssertEqual(sut.movies.count, 1)
        XCTAssertEqual(sut.movies.first?.id, exampleMovie.id)
    }
    
    func testMoves_updatesWhenMarked() async throws {
        var movie = exampleMovie
        services.expectedFetchMoviesResults = [movie]

        await sut.fetchMovies()
        
        movie.isMarked.toggle()
        services.expectedMarkedMovies.insert(movie.id)
                
        XCTAssertTrue(sut.movies[0].isMarked)
    }
}

private let exampleMovie = MovieVM(
    id: UUID().uuidString,
    title: "Monster Hunter",
    genres: "ACTION, FANTASY, THRILLER",
    overView: "A portal transports Cpt. Artemis and an elite unit of soldiers to a strange world where powerful monsters rule with deadly ferocity. Faced with relentless danger, the team encounters a mysterious hunter who may be their only hope to find a way home.",
    image: .init(
        small: "https://image.tmdb.org/t/p/w185/1UCOF11QCw8kcqvce8LKOO6pimh.jpg",
        large: "https://image.tmdb.org/t/p/w500/1UCOF11QCw8kcqvce8LKOO6pimh.jpg"),
    popularity: 7.1,
    isMarked: false
)
