//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

final class MovieDetailsScreenViewModel: ObservableObject, MovieDetailsScreenViewModelProtocol {
    @Published var movie: MovieVM
    private let movieServices: MovieServicesProtocol

    init(movie: MovieVM,
         movieServices: MovieServicesProtocol = MovieServices.shared) {
        self.movie = movie
        self.movieServices = movieServices
    }

    func markMovie() {
        movie.isMarked.toggle()
        movieServices.updateMarks(by: movie)
    }
}
