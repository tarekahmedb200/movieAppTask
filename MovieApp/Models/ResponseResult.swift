//
//  Result.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation


struct ResponseResult : Codable {
    
    var page : Int
    var totalPages : Int
    var totalResults : Int
    var movies : [Movie]
    
    enum CodingKeys : String , CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
    
}
