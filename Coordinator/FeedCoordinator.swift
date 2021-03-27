//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 25.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let feedViewController = FeedViewController.instantiate()
        feedViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: true)
    }
    
    func showPostViewController() {
        
    }
}
