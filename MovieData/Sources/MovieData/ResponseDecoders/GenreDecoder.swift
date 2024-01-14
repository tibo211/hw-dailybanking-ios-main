//
//  File.swift
//  
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import Foundation

private struct FetchGenresResponse: Decodable {
    struct Genre: Decodable {
        let id: Int
        let name: String
    }

    let genres: [Genre]
}

enum GenreDecoder {
    static func decode(data: Data) throws -> [Int : String] {
        let response = try JSONDecoder().decode(FetchGenresResponse.self, from: data)
        return Dictionary(grouping: response.genres, by: \.id)
            .compactMapValues(\.first?.name)
    }
}
