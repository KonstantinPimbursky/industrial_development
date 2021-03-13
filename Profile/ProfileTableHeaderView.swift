//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private let profileHeaderView = ProfileHeaderView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileHeaderView)
        setupProfileHeaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        

    }
    
    private func setupProfileHeaderView() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .lightGray
        
        let constraints = [
            profileHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

