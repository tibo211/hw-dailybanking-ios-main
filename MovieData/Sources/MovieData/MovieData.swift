// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct MovieData {
    public static func createRepository(APIKey: String) -> MovieRepository {
        DefaultMovieRepository(APIKey: APIKey)
    }
}
