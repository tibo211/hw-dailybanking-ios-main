//
//  MovieRepository.swift
//
//
//  Created by Tibor Felföldy on 2024-01-13.
//

import Foundation
import Combine

public protocol MovieRepository {
    /// Calls the TMDB API `/movie/popular`.
    /// - Returns: The first page of the popular movies.
    func fetchPopularMovies() async throws -> [Movie]
    
    /// Calls the TMDB API `/genre/movie/list`.
    /// - Returns: Dictionary where the key is the id and the value is the name of the genre.
    func fetchGenres() async throws -> [Int : String]
}

// MARK: - API Responses.

struct FetchPopularMoviesResponse: Decodable {
    let results: [Movie]
}

struct FetchGenresResponse: Decodable {
    struct Genre: Decodable {
        let id: Int
        let name: String
    }

    let genres: [Genre]
}

// MARK: - Default implementation.

final class DefaultMovieRepository: MovieRepository {
    enum Endpoint: String {
        case popular = "/movie/popular"
        case genres = "/genre/movie/list"
    }
    
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3"
    
    init(APIKey: String) {
        self.apiKey = APIKey
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        let url = url(for: .popular)

        let (data, _) = try await URLSession.shared.data(from: url)

        let response = try decodeMovies(data: data)
        return response.results
    }
    
    func fetchGenres() async throws -> [Int : String] {
        let url = url(for: .genres)
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let results = try decodeGenres(data: data)
        return results
    }
}

extension DefaultMovieRepository {
    func url(for endpoint: Endpoint) -> URL {
        var components = URLComponents(string: baseURL + endpoint.rawValue)
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        return components!.url!
    }
    
    func decodeMovies(data: Data) throws -> FetchPopularMoviesResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(FetchPopularMoviesResponse.self, from: data)
    }
    
    func decodeGenres(data: Data) throws -> [Int : String] {
        let response = try JSONDecoder().decode(FetchGenresResponse.self, from: data)
        return Dictionary(grouping: response.genres, by: \.id)
            .compactMapValues(\.first?.name)
    }
}
