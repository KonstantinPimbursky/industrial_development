//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 14.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let profileTableHeaderView = ProfileTableHeaderView()
    private var timerCount = 30
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setTableView()
        setupViews()
        let timer = Timer(timeInterval: 1, repeats: true) { (_) in
            self.timerCount -= 1
            self.timerLabel.text = "\(self.timerCount)"
        }
        
        let timerToPop = Timer.scheduledTimer(timeInterval: 30,
                                              target: self,
                                              selector: #selector(popToLoginViewController),
                                              userInfo: nil,
                                              repeats: true)
        
        RunLoop.main.add(timer, forMode: .common)
        RunLoop.main.add(timerToPop, forMode: .common)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func popToLoginViewController() {
        navigationController?.popToRootViewController(animated: true)
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
        view.addSubview(timerLabel)
        
        let contraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(contraints)
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
