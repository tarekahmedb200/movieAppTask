//
//  Movie.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation



struct Movie: Codable {
    
    var id: Int
    var posterPath: String
    var overview: String
    var releaseDate: String
    var title: String
    var backdropPath: String
   
    enum CodingKeys : String , CodingKey {
        case id
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
        case backdropPath = "backdrop_path"
    }
    
}
