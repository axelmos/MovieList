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
    case upcoming
    case topRated
    
    var subPath: String {
        switch self {
        case .upcoming: return "list/1"
        case .topRated: return "list/2"
        }
    }
    
    var basePath: String {
        if enviroment == .dev { return "https://api.themoviedb.org/4/" } 
        
        switch self {
        case .upcoming, .topRated: return "https://api.themoviedb.org/4/"
        }
    }
}
