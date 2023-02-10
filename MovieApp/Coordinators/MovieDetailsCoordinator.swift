//
//  MovieDetailsCoordinator.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation
import UIKit

class MovieDetailsCoordinator {
    
    var navigationController: UINavigationController
    var movieID: Int


    init(navigationController:UINavigationController,movieID:Int) {
        self.navigationController = navigationController
        self.movieID = movieID
    }

    func start() {
        let articleDetailsViewModel = getMovieDetailsViewModel()
        guard let  atricleDetailsDetailsViewController = MovieDetailsViewController.instantiate(with: articleDetailsViewModel) else {
            return
        }
        navigationController.pushViewController(atricleDetailsDetailsViewController, animated: false)
    }

    private func getMovieDetailsViewModel() -> MovieDetailsViewModel {
        return MovieDetailsViewModel(api: getApi(), movieID: movieID)
    }
    
    private func getApi() -> APIProtocol {
        let movieDbApi = MovieDBAPI()
        return movieDbApi
    }

}



