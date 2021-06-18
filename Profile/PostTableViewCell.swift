//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 04.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    var onDoubleTapped: ((_ post: PostModel) -> Void)?
    
    var post: PostModel? {
        didSet {
            postAuthorLabel.text = post?.author
            postImageView.image = UIImage(named: post!.image)
            postDescriptionLabel.text = post?.description
            likesLabel.text = "Likes: \(post!.likes)"
            viewsLabel.text = "Views: \(post!.views)"
        }
    }
    
    private let postAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(postTapped))
        tapGestureRecognizer.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(tapGestureRecognizer)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func postTapped() {
        if let doubleTapped = self.onDoubleTapped,
           let post = post {
            doubleTapped(post)
        }
    }
    
    private func setupViews() {
        contentView.addSubviews(postAuthorLabel, postImageView, postDescriptionLabel, likesLabel, viewsLabel)
        
        postAuthorLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postAuthorLabel.snp.bottom).offset(12)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.width)
        }
        
        postDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        likesLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(16)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
        viewsLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}


