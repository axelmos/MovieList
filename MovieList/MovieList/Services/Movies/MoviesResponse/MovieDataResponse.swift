//
//  MovieDataResponse.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

struct MovieDataResponse : Decodable{
    var data : [Movie]
    
    private enum CodingKeys : String, CodingKey{
        case data = "results"
    }
}
