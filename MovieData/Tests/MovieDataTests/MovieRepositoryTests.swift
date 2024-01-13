//
//  MovieRepositoryTests.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

import XCTest
@testable import MovieData

final class MovieRepositoryTests: XCTestCase {
    @available(iOS 16.0, *)
    func testURLCreation() {
        let sut = DefaultMovieRepository(APIKey: "APIKEY")

        let url = sut.url(for: .popular)

        let urlToExpect = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=APIKEY")
        XCTAssertEqual(url, urlToExpect)
    }
    
    func testDecodingMovie() throws {
        let sut = DefaultMovieRepository(APIKey: "APIKEY")
        let data = exampleResponse.data(using: .utf8)!
        
        let response = try sut.decode(data: data)
        
        XCTAssertEqual(response.results.count, 2)
        
        guard let movie = response.results.first else {
            XCTFail("Missing results")
            return
        }
        
        XCTAssertEqual(movie.id, 753342)
        XCTAssertEqual(movie.title, "Napoleon")
        XCTAssertFalse(movie.overview.isEmpty)
        XCTAssertEqual(movie.genreIds, [36, 10752, 18])
        XCTAssertEqual(movie.posterPath, "/f1AQhx6ZfGhPZFTVKgxG91PhEYc.jpg")
        XCTAssertEqual(movie.popularity, 1529.676)
    }
}

let exampleResponse = """
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/f1AQhx6ZfGhPZFTVKgxG91PhEYc.jpg",
      "genre_ids": [36, 10752, 18],
      "id": 753342,
      "original_language": "en",
      "original_title": "Napoleon",
      "overview": "An epic that details the checkered rise and fall of French Emperor Napoleon Bonaparte and his relentless journey to power through the prism of his addictive, volatile relationship with his wife, Josephine.",
      "popularity": 1529.676,
      "poster_path": "/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg",
      "release_date": "2023-11-22",
      "title": "Napoleon",
      "video": false,
      "vote_average": 6.5,
      "vote_count": 1023
    },
    {
      "adult": false,
      "backdrop_path": "/vdpE5pjJVql5aD6pnzRqlFmgxXf.jpg",
      "genre_ids": [18, 36],
      "id": 906126,
      "original_language": "es",
      "original_title": "La sociedad de la nieve",
      "overview": "On October 13, 1972, Uruguayan Air Force Flight 571, chartered to take a rugby team to Chile, crashes into a glacier in the heart of the Andes.",
      "popularity": 1417.534,
      "poster_path": "/2e853FDVSIso600RqAMunPxiZjq.jpg",
      "release_date": "2023-12-13",
      "title": "Society of the Snow",
      "video": false,
      "vote_average": 8.1,
      "vote_count": 629
    }
  ],
  "total_pages": 41950,
  "total_results": 838984
}
"""
