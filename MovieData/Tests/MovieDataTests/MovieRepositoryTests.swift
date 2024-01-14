//
//  MovieRepositoryTests.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

import XCTest
@testable import MovieData

final class MovieRepositoryTests: XCTestCase {
    func testURL_createTrending() {
        let sut = DefaultMovieRepository(APIKey: "APIKEY")

        let url = sut.url(for: .trending)

        let urlToExpect = URL(
            string: "https://api.themoviedb.org/3/trending/movie/day?api_key=APIKEY"
        )
        XCTAssertEqual(url, urlToExpect)
    }
    
    func testURL_createGenres() {
        let sut = DefaultMovieRepository(APIKey: "APIKEY")
        
        let url = sut.url(for: .genres)
        
        let urlToExpect = URL(
            string: "https://api.themoviedb.org/3/genre/movie/list?api_key=APIKEY"
        )
        XCTAssertEqual(url, urlToExpect)
    }
}
