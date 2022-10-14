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
    }
    
    struct Titles {
        static let upcomingHeader = "PRÓXIMOS ESTRENOS"
        static let topRatedHeader = "TENDENCIA"
    }
}
