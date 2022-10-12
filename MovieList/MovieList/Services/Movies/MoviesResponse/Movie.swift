//
//  Movie.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

struct Movie: Decodable {
    var title: String
    var poster_path: String
    var overview: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case poster_path
        case overview
    }
}
