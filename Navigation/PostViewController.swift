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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.backgroundColor = .systemPink
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(showInfoViewController))
        
    }
    
    @objc private func showInfoViewController() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
}
