//
//  MovieServicesTests.swift
//  MoviesTests
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import XCTest
import MovieData
@testable import Movies

final class MovieServicesTests: XCTestCase {
    private var movieRepository: MockMovieRepository!
    private var sut: MovieServices!
    
    override func setUp() {
        let formatter = ListFormatter()
        formatter.locale = Locale(identifier: "en")
        
        movieRepository = MockMovieRepository()
        
        sut = MovieServices(
            repository: movieRepository,
            formatter: formatter
        )
    }
    
    func testConvert() {
        let genres = [
            18 : "Drama",
            36 : "History"
        ]
        
        let movie = Movie(
            id: 10,
            title: "Society of the Snow",
            overview: "On October 13, 1972, Uruguayan Air Force Flight 571, chartered to take a rugby team to Chile, crashes into a glacier in the heart of the Andes.",
            genreIds: [18, 36],
            voteAverage: 8.1,
            posterPath: "/2e853FDVSIso600RqAMunPxiZjq.jpg"
        )
        
        let movieVM = sut.convert(movie: movie, genres: genres)
        
        XCTAssertEqual(movieVM.id, String(movie.id))
        XCTAssertEqual(movieVM.title, movie.title)
        XCTAssertEqual(movieVM.genres, "Drama and History")
        XCTAssertEqual(movieVM.overView, movie.overview)
        XCTAssertEqual(movieVM.popularity, movie.voteAverage)
        XCTAssertEqual(movieVM.image.small, movie.smallImageLink)
        XCTAssertEqual(movieVM.image.large, movie.largeImageLink)
    }
    
    func testFetchMovies_doAPICalls() async throws {
        let movies = try await sut.fetchMovies()
        
        XCTAssertEqual(movieRepository.fetchGenresCallCount, 1)
        XCTAssertEqual(movieRepository.fetchPopularMoviesCallCount, 1)
    }
}
