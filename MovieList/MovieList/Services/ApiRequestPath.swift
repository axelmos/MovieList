//
//  ApiRequestPath.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

enum Enviroment {
   case dev
   case prod
}
 
var enviroment: Enviroment = .prod

enum ApiRequestPath {
    case allMovies
    
    var subPath: String {
        switch self {
        case .allMovies: return "list/1"
        }
    }
    
    var basePath: String {
        if enviroment == .dev { return "https://api.themoviedb.org/4/" } 
        
        switch self {
        case .allMovies: return "https://api.themoviedb.org/4/"
        }
    }
}
