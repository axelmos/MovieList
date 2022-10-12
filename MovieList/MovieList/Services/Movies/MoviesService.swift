//
//  MoviesService.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

final class MoviesService : ApiService {
    func getAllMovies(sortBy: String, page: Int, completion: @escaping ([Movie]) -> Void, failure: @escaping (String) -> Void) {
        
        let params = MovieApiParameters(sortBy: sortBy, page: page)
        let apiParameters = ApiRequestParameters(parameters: params)
        let request = ApiRequest(path: .allMovies, method: .get, parameters:apiParameters)
        
        self.request(request, completion: { (response: MovieDataResponse) in
            completion(response.data)
        }, failure: { error in
            failure(error.message)
        })
    }
}
