//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

final class MoviesScreenViewModel: ObservableObject, MoviesScreenViewModelProtocol {
    @Published private(set) var movies: [MovieVM] = []
    
    private let movieServices = MovieServices()
    
    func fetchMovies() async {
        let movies = try? await movieServices.fetchMovies() 
        
        await MainActor.run {
            self.movies = movies ?? []
        }
    }
}
