//
//  MovieApiParameters.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

struct MovieApiParameters: ApiParametersProtocol {
    
    var sortBy: String?
    var page: Int?
     
    init(sortBy: String?, page: Int?) {
        self.sortBy = sortBy
        self.page = page
    }
    
    func queryParams() -> ApiParameters {
        return ["page": page ?? 1, "sort_by": sortBy ?? ""]
    }
}
