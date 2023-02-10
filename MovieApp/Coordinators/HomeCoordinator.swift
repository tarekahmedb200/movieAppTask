//
//  HomeCoordinator.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation
import UIKit

class HomeCoordinator {

    var navigationController: UINavigationController
        
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewModel = getHomeViewModel()
        guard let homeViewController = HomeViewController.instantiate(with: homeViewModel)
            else {
                return
            }
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
    private func getHomeViewModel() -> HomeViewModel {
        let homeViewModel = HomeViewModel(api: getApi(),homeCoordinator: self)
        return homeViewModel
    }
    
    private func getApi() -> APIProtocol {
        let movieDbApi = MovieDBAPI()
        return movieDbApi
    }
    
    func navigateToMovieDetailsViewController(movieID: Int) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: self.navigationController,movieID: movieID)
        movieDetailsCoordinator.start()
    }

}
