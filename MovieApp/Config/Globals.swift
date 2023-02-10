//
//  Globals.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation

struct APIAuth : Codable {
    static let ApiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
}

enum movieDBURL   {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKeyParameter = "?api_key="
    static let pageParameter = "&page="
    
    case requestTrendingMovies(page:Int)
    case requestMovieDetails(movieID:Int)
    case getPosterImage(path:String)
    
    var url : URL? {
        guard let url = URL(string: self.stringUrl) else {
            return nil
        }
        return url
    }
    
    var stringUrl: String {
        switch self {
        case .requestTrendingMovies(let page):
            return movieDBURL.baseUrl + "/discover/"+"/movie" + movieDBURL.apiKeyParameter + APIAuth.ApiKey + movieDBURL.pageParameter + "\(page)"
        case .requestMovieDetails(let movieID):
            return  movieDBURL.baseUrl + "/movie/\(movieID)" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        case .getPosterImage(let path):
            return "https://image.tmdb.org/t/p/w500/"+path
        }
    }
    
    
}
