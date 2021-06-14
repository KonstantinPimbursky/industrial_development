//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 05.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class LikedPostsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setupViews()
        self.title = "Liked Posts"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self)
        )
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getLikedPosts() -> [LikedPosts] {
        let coreDataStack = CoreDataStack()
        return coreDataStack.fetchLikedPosts()
    }


}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let likedPosts = self.getLikedPosts()
        return likedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        let likedPosts = self.getLikedPosts()
        let likedPost = likedPosts[indexPath.row]
        let post = PostModel(author: likedPost.postAuthor,
                             description: likedPost.postDescription,
                             image: likedPost.postImage,
                             likes: Int(likedPost.postLikes),
                             views: Int(likedPost.postViews))
        
        cell.post = post
        
        return cell
    }
}
