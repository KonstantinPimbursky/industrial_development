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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController.instantiate()
        feedViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: false)
    }
}

