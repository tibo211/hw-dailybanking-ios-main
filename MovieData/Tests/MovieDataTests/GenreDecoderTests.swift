//
//  GenreDecoderTests.swift
//
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import XCTest
@testable import MovieData

final class GenreDecoderTests: XCTestCase {
    func testDecode() throws {
        let data = genresExampleResponse.data(using: .utf8)!
        
        let genres = try GenreDecoder.decode(data: data)
        
        XCTAssertEqual(genres[28], "Action")
        XCTAssertEqual(genres[12], "Adventure")
        XCTAssertEqual(genres[16], "Animation")
    }
}

private let genresExampleResponse = """
{
  "genres": [
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"}
  ]
}
"""
