//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import SwiftUI

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    var signOut: (() -> Void)?
    
    private var profileHeaderView = ProfileHeaderView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        profileHeaderView.signOut = logOut
        contentView.addSubview(profileHeaderView)
        setupProfileHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func logOut() {
        signOut!()
    }
    
    private func setupProfileHeaderView() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .lightGray
        
        profileHeaderView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(220)
        }
    }
}
