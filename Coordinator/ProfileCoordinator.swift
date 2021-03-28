//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 25.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func showProfileViewController() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func showPhotosViewController() {
        let photosViewController = PhotosViewController()
        photosViewController.coordinator = self
        navigationController.pushViewController(photosViewController, animated: true)
    }
}
