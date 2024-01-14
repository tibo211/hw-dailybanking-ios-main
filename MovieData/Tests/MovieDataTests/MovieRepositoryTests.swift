//
//  MovieRepositoryTests.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

import XCTest
@testable import MovieData

final class MovieRepositoryTests: XCTestCase {
    private var mockURLSession: MockURLSession!
    private var sut: DefaultMovieRepository!
    
    override func setUp() {
        mockURLSession = MockURLSession()
        sut = DefaultMovieRepository(APIKey: "APIKEY", urlSession: mockURLSession)
    }
    
    func testFetchTrendingMovies_URL() async throws {
        mockURLSession.expectedResponse = popularMoviesExampleResponse

        _ = try await sut.fetchTrendingMovies()

        let urlToExpect = URL(
            string: "https://api.themoviedb.org/3/trending/movie/day?api_key=APIKEY"
        )
        XCTAssertEqual(mockURLSession.receivedURL, urlToExpect)
    }
    
    func testFetchTrendingMovies_returnsTrendingMovies() async throws {
        mockURLSession.expectedResponse = popularMoviesExampleResponse
        
        let results = try await sut.fetchTrendingMovies()
        
        XCTAssertEqual(results.count, 2)
    }
    
    func testFetchGenres_URL() async throws {
        mockURLSession.expectedResponse = genresExampleResponse

        _ = try await sut.fetchGenres()
        
        let urlToExpect = URL(
            string: "https://api.themoviedb.org/3/genre/movie/list?api_key=APIKEY"
        )
        XCTAssertEqual(mockURLSession.receivedURL, urlToExpect)
    }
    
    func testFetchGenres_returnsGenres() async throws {
        mockURLSession.expectedResponse = genresExampleResponse
        
        let results = try await sut.fetchGenres()
        
        XCTAssertEqual(results.count, 3)
    }
}
