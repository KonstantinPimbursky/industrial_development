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
    
    var coreDataStack: CoreDataStack!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var authorFilter: String? = nil
    private var likedPosts: [LikedPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard coreDataStack != nil else {
            fatalError("This view needs a coreDataStack")
        }
        setTableView()
        setupViews()
        self.title = "Liked Posts"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getLikedPosts(filteredBy: authorFilter)
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
    
    private func getLikedPosts(filteredBy author: String?) {
        likedPosts = coreDataStack.fetchLikedPosts(filteredBy: author)
    }
    
    private func deleteLikedPost(likedPost: LikedPost) {
        coreDataStack.remove(likedPost: likedPost)
        getLikedPosts(filteredBy: authorFilter)
    }


}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        let likedPost = self.likedPosts[indexPath.row]
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
            let likedPost = self.likedPosts[indexPath.row]
            self.deleteLikedPost(likedPost: likedPost)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        delete.image = UIImage(systemName: "trash")
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
