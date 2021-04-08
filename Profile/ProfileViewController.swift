//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 14.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let profileTableHeaderView = ProfileTableHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setTableView()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setTableView () {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self)
        )
        tableView.register(
            ProfileTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self)
        )
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
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
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            let tableSection: PostSection = Storage.tableModel[section - 1]
            return tableSection.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
                        
            return cell
        default:
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            
            let tableSection: PostSection = Storage.tableModel[indexPath.section - 1]
            let post: PostModel = tableSection.posts[indexPath.row]
            
            cell.post = post
            
            return cell
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(
        withIdentifier: String(describing: ProfileTableHeaderView.self)) as! ProfileTableHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}
