//
//  APIProtocol.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation


protocol APIProtocol: AnyObject {
    func  getTrendingMovies(page:Int,completion: @escaping ([Movie]?,Error?) -> Void)
    func  getMovieDetails(movieID:Int,completion: @escaping (Movie?,Error?) -> Void)
}

