//
//  MovieDecoderTests.swift
//
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import XCTest
@testable import MovieData

final class MovieDecoderTests: XCTestCase {
    func testDecode() throws {
        let data = popularMoviesExampleResponse
            .data(using: .utf8)!
        
        let results = try MovieDecoder.decode(data: data)
        
        XCTAssertEqual(results.count, 2)
        
        guard let movie = results.first else {
            XCTFail("Missing results")
            return
        }
        
        XCTAssertEqual(movie.id, 753342)
        XCTAssertEqual(movie.title, "Napoleon")
        XCTAssertFalse(movie.overview.isEmpty)
        XCTAssertEqual(movie.genreIds, [36, 10752, 18])
        XCTAssertEqual(movie.posterPath, "/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg")
        XCTAssertEqual(movie.voteAverage, 6.5)
    }
}
