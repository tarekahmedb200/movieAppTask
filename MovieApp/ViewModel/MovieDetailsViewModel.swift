//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation
import RxSwift
import RxCocoa


enum MovieDetailsCells : CaseIterable {
    case movieImageCell
    case movieTitleCell
    case movieRelaseDateCell
    case movieDescriptionCell
}

class MovieDetailsViewModel {
    
    var api: APIProtocol
    var movieDetails : Movie?
    var movieID: Int = 0
    var movieDetailsCells = [MovieDetailsCells]()
    
    
    enum state {
        case idle
        case reloadData
        case showActivity
        case hideActivity
    }
    
    private var viewState = BehaviorRelay<state>(value: .idle)
    
    var stateObservable : Driver<state>   {
        return viewState.asDriver()
    }
    
    init(api:APIProtocol,movieID:Int) {
        self.api = api
        self.movieID = movieID
        loadMovieDetails()
    }
    
    private func loadMovieDetails() {
        viewState.accept(.showActivity)
        api.getMovieDetails(movieID: self.movieID) { [weak self] movieDetails , error in
            
            guard let weakSelf = self else {
                return
            }
        
            guard error == nil else {
                weakSelf.viewState.accept(.hideActivity)
                return
            }
            
            guard let movieDetails = movieDetails else {
                weakSelf.viewState.accept(.hideActivity)
                return
            }
            
            weakSelf.viewState.accept(.hideActivity)
            weakSelf.movieDetails = movieDetails
            weakSelf.setupMovieDetailsCells()
        }
    }
    
    private func setupMovieDetailsCells() {
        MovieDetailsCells.allCases.forEach { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.movieDetailsCells.append($0)
            weakSelf.viewState.accept(.reloadData)
        }
    }
    
    
    
}



