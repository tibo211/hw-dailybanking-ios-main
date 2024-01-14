//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

final class MoviesScreenViewModel: ObservableObject, MoviesScreenViewModelProtocol {
    @Published private(set) var movies: [MovieVM] = []
    
    private var movieServices: MovieServicesProtocol
    
    init(movieServices: MovieServicesProtocol = MovieServices.shared) {
        self.movieServices = movieServices
        
        // Update marked movies.
        movieServices.markedMoviesPublisher
            .combineLatest($movies) { marked, movies in
                movies.map { movie in
                    var newMovie = movie
                    newMovie.isMarked = marked.contains(movie.id)
                    return newMovie
                }
            }
            .assign(to: &$movies)
    }
    
    func fetchMovies() async {
        let movies = try? await movieServices.fetchMovies() 
        
        await MainActor.run {
            self.movies = movies ?? []
        }
    }
}
