//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

class MovieViewModel {
    var _movies: [Movie]?
    var service: MoviesService
    
    init(service: MoviesService = MoviesService()) {
        self.service = service
    }
}

extension MovieViewModel: MovieProtocol {
    var movies: [Movie] {
        return _movies ?? []
    }
    
    func getUpcomingMovies(sortBy: String, page: Int, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        service.getUpcomingMovies(sortBy: sortBy, page: page) { [weak self] data in
            self?._movies = data
            completion()
        } failure: { error in
            failure(error)
        }
    }
    
    func getTopRatedMovies(sortBy: String, page: Int, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        service.getTopRatedMovies(sortBy: sortBy, page: page) { [weak self] data in
            self?._movies = data
            completion()
        } failure: { error in
            failure(error)
        }
    }
}
