//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    enum state {
        case idle
        case reloadData
        case showActivity
        case hideActivity
    }
    
    enum action {
        case clickMovie(movieID:Int)
        case getNextPage
    }
    
    func onAction(action:action) {
        switch action {
        case .clickMovie(let movieID):
            homeCoordinator.navigateToMovieDetailsViewController(movieID: movieID)
        case .getNextPage:
            page += 1
            loadMoviesList()
        }
    }
    
    var api: APIProtocol
    var movieList : [Movie] = []
    var homeCoordinator : HomeCoordinator
    var page: Int = 1
    
    
    
    
    private var viewState = BehaviorRelay<state>(value: .idle)
    
    var stateObservable : Driver<state> {
        return viewState.asDriver()
    }
    
    init(api:APIProtocol,homeCoordinator: HomeCoordinator) {
        self.api = api
        self.homeCoordinator = homeCoordinator
        loadMoviesList()
    }
    
    private func loadMoviesList() {
        
        viewState.accept(.showActivity)
        
        api.getTrendingMovies(page: page) { [weak self] movieList, error in

            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.viewState.accept(.hideActivity)
                return
            }
            
            guard let movieList = movieList else {
                weakSelf.viewState.accept(.hideActivity)
                return
            }
            
            
            weakSelf.viewState.accept(.hideActivity)
            weakSelf.movieList.append(contentsOf: movieList)
            weakSelf.viewState.accept(.reloadData)
        }
    }
    

    
    
}
