//
//  MovieRepository.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

import Foundation
import Combine

public protocol MovieRepository {
    /// Calls the TMDB API `/trending/movie`.
    /// - Returns: The trending movies of the day.
    func fetchTrendingMovies() async throws -> [Movie]
    
    /// Calls the TMDB API `/genre/movie/list`.
    /// - Returns: Dictionary where the key is the id and the value is the name of the genre.
    func fetchGenres() async throws -> [Int : String]
}

// MARK: - Default implementation.

final class DefaultMovieRepository: MovieRepository {
    private enum Endpoint: String {
        case trending = "/trending/movie/day"
        case genres = "/genre/movie/list"
    }
    
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3"
    private let urlSession: URLSessionProtocol
    
    init(APIKey: String, urlSession: URLSessionProtocol = URLSession.shared) {
        self.apiKey = APIKey
        self.urlSession = urlSession
    }
    
    func fetchTrendingMovies() async throws -> [Movie] {
        let url = url(for: .trending)

        let (data, _) = try await urlSession.data(from: url)

        let results = try MovieDecoder.decode(data: data)
        return results
    }
    
    func fetchGenres() async throws -> [Int : String] {
        let url = url(for: .genres)
        
        let (data, _) = try await urlSession.data(from: url)
        
        let results = try GenreDecoder.decode(data: data)
        return results
    }
}

// MARK: URL maker.

extension DefaultMovieRepository {
    private func url(for endpoint: Endpoint) -> URL {
        var components = URLComponents(string: baseURL + endpoint.rawValue)
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        return components!.url!
    }
}
