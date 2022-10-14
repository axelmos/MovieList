//
//  Constants.swift
//  MovieList
//
//  Created by Axel Mosiejko on 14/10/2022.
//

import Foundation

struct Constants {
    
    struct Services {
        static let imageURL = "https://image.tmdb.org/t/p/w500"
        static let baseURL = "https://api.themoviedb.org/4/"
        static let upcoming = "list/1"
        static let topRated = "list/2"
        static let encodingType = "application/json"
        static let authorization = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYmI3MWQ2MmZjYmI1ODA1M2U2MWNlYjViYTg0ZDcxMCIsInN1YiI6IjYzNDcxNGY2ZmU1YzkxMDA3ZWQxZjlhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7u1z18ZgPDefN4FB6I8JuAr4u7w0hM_M9mCk2n93mF8"
        static let contentType = "application/json;charset=utf-8"
    }
    
    struct Titles {
        static let upcomingHeader = "PRÓXIMOS ESTRENOS"
        static let topRatedHeader = "TENDENCIA"
    }
}
