//
//  MovieDetaislViewModel.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetaislViewModel {
    var api: APIProtocol
    var movieDetails : Movie?
    var movieID: Int = 0
    
    private var viewState = BehaviorRelay<state>(value: .idle)
    
    var stateObservable : Observable<state>   {
        return viewState.asObservable()
    }
    
    init(api:APIProtocol,movieID:Int) {
        self.api = api
        self.movieID = movieID
        loadMovieDetails()
    }
    
    private func loadMovieDetails() {
        api.getMovieDetails(movieID: self.movieID) { [weak self] movieDetails , error in
            
            guard let weakSelf = self else {
                return
            }
        
            guard error == nil else {
                return
            }
            
            guard let movieDetails = movieDetails else {
                return
            }
            
            weakSelf.movieDetails = movieDetails
            weakSelf.viewState.accept(.reloadData)
        }
    }
    
    enum state {
        case idle
        case reloadData
    }
    
    enum action {
        case clickMovie(movieID:Int)
    }
    
    func onAction(action:action) {
        switch action {
        case .clickMovie(let movieID):
            break
        }
    }
    
}



