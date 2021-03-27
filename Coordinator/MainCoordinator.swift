//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 23.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
// MARK: Protocol
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

// MARK: Class
class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let tabBarController = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedNav: UINavigationController = {
            let nav = UINavigationController()
            nav.tabBarItem.title = "Feed"
            nav.tabBarItem.image = UIImage(systemName: "house.fill")
            nav.tabBarItem.tag = 0
            return nav
        }()
        
        let profileNav: UINavigationController = {
            let nav = UINavigationController()
            nav.tabBarItem.title = "Profile"
            nav.tabBarItem.image = UIImage(systemName: "person.fill")
            nav.tabBarItem.tag = 1
            return nav
        }()
        
        let feedCoordinator = FeedCoordinator(navController: feedNav)
        let profileCoordinator = ProfileCoordinator(navController: profileNav)
        feedCoordinator.start()
        profileCoordinator.start()
        tabBarController.viewControllers = [feedCoordinator.navigationController,
                                            profileCoordinator.navigationController]
        let presenter = FeedViewController.instantiate()
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(presenter, animated: true)
    }
}
