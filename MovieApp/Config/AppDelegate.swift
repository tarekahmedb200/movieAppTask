//
//  AppDelegate.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var homeCoordinator : HomeCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

