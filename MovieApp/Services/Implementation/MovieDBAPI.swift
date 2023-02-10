//
//  MovieDBAPI.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation



class MovieDBAPI: APIProtocol {
    
    func getTrendingMovies(page:Int,completion: @escaping ([Movie]?,Error?) -> Void) {
        
        guard let url = URL(string: movieDBURL.requestTrendingMovies(page: page).stringUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            
            
            do {
                let response = try JSONDecoder().decode(ResponseResult.self, from: data)
                completion(response.movies,nil)
            }catch let error {
                completion(nil,error)
            }
        }.resume()
    }
    
    func getMovieDetails(movieID: Int, completion: @escaping (Movie?,Error?) -> Void) {

        guard let url = URL(string: movieDBURL.requestMovieDetails(movieID: movieID).stringUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }

            let dd = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print(dd)

            do {
                let movieDetails = try JSONDecoder().decode(Movie.self, from: data)
                completion(movieDetails,nil)
            }catch let error {
                completion(nil,error)
            }
        }.resume()
    }
    
    
}


