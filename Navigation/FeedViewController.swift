//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController, Storyboarded {
    
    let post: Post = Post(title: "Пост")
    var coordinator: FeedCoordinator?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
    }
    
    @IBAction func firstOpenPostAction (_ sender: Any) {
        coordinator?.showPostViewController()
    }
    
    
    @IBAction func secondOpenPostAction(_ sender: Any) {
        coordinator?.showPostViewController()
    }
    
}
