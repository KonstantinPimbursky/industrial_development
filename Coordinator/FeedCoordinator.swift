//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 25.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedCoordinator: Coordinator {
    
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
        let postViewController = PostViewController()
        postViewController.coordinator = self
        navigationController.pushViewController(postViewController, animated: true)
    }
    
    func presentInfoViewController() {
        let infoViewController = InfoViewController.instantiate()
        infoViewController.coordinator = self
        navigationController.present(infoViewController, animated: true, completion: nil)
    }
}
