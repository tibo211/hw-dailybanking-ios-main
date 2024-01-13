//
//  MovieRepository.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

import Foundation

public protocol MovieRepository {
    func fetchMovies() async throws -> [Movie]
}

struct FetchMoviesResponse: Decodable {
    let results: [Movie]
}

final class DefaultMovieRepository: MovieRepository {
    enum Endpoint: String {
        case popular = "/movie/popular"
    }
    
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3"
    
    init(APIKey: String) {
        self.apiKey = APIKey
    }
    
    func fetchMovies() async throws -> [Movie] {
        let url = url(for: .popular)
        // Request.
        let (data, _) = try await URLSession.shared.data(from: url)
        // Decode.
        let response = try decode(data: data)
        return response.results
    }
    
    func url(for endpoint: Endpoint) -> URL {
        var components = URLComponents(string: baseURL + endpoint.rawValue)
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        return components!.url!
    }
    
    func decode(data: Data) throws -> FetchMoviesResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(FetchMoviesResponse.self, from: data)
    }
}
