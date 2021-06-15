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
    private let coreDataStack = CoreDataStack()
    private var authorFilter: String? = nil

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
    
    private func setupViews() {
        let rightBarButtonItem = UIBarButtonItem(title: "Фильтр",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(addAthorFilter))
        let leftBarButtonItem = UIBarButtonItem(title: "Очистить фильтр",
                                                style: .plain,
                                                target: self,
                                                action: #selector(clearFilter))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addAthorFilter() {
        let alertController = UIAlertController(title: "Фильтр по автору",
                                                message: "Введите автора для фильтра постов",
                                                preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let filterAction = UIAlertAction(title: "Применить", style: .default) { [weak self] _ in
            self?.authorFilter = alertController.textFields?[0].text
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        alertController.addAction(filterAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func clearFilter() {
        authorFilter = nil
        tableView.reloadData()
    }
    
    private func getLikedPosts(authorFilter: String?) -> [LikedPosts] {
        return coreDataStack.fetchLikedPosts(authorFilter: authorFilter)
    }
    
    private func deleteLikedPost(likedPost: LikedPosts) {
        coreDataStack.remove(likedPost: likedPost)
    }


}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let likedPosts = self.getLikedPosts(authorFilter: authorFilter)
        return likedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        let likedPosts = self.getLikedPosts(authorFilter: authorFilter)
        let likedPost = likedPosts[indexPath.row]
        let post = PostModel(author: likedPost.postAuthor,
                             description: likedPost.postDescription,
                             image: likedPost.postImage,
                             likes: Int(likedPost.postLikes),
                             views: Int(likedPost.postViews))
        
        cell.post = post
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let likedPosts = self.getLikedPosts(authorFilter: self.authorFilter)
            let likedPost = likedPosts[indexPath.row]
            self.deleteLikedPost(likedPost: likedPost)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        delete.image = UIImage(systemName: "trash")
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
