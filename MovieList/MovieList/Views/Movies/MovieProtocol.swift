//
//  MovieProtocol.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

protocol MovieProtocol {
    var movies: [Movie] { get }
    
    func getAllMovies(sortBy: String, page: Int, completion: @escaping () -> (), failure: @escaping (String) -> ())
}
