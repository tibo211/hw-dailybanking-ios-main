//
//  MovieDecoder.swift
//
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import Foundation

private struct FetchPopularMoviesResponse: Decodable {
    let results: [Movie]
}

enum MovieDecoder {
    static func decode(data: Data) throws -> [Movie] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(FetchPopularMoviesResponse.self, from: data)
        return response.results
    }
}
