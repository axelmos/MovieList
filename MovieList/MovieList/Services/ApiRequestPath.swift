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
        case .upcoming: return Constants.Services.upcoming
        case .topRated: return Constants.Services.topRated
        }
    }
    
    var basePath: String {
        if enviroment == .dev { return Constants.Services.baseURL }
        
        switch self {
        case .upcoming, .topRated: return Constants.Services.baseURL
        }
    }
}
