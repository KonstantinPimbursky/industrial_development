//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?
    var coordinator: FeedCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.backgroundColor = .systemPink
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentInfoViewController))
    }
    
    @objc func presentInfoViewController() {
        coordinator?.presentInfoViewController()
    }
}
