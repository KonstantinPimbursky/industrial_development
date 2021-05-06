//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 08.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    private let stackOfPhotos: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(systemName: "arrow.right")
        imageView.tintColor = UIColor.black
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(photosLabel, stackOfPhotos, arrowImage)
        setupStackOfPhotos()
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {

        photosLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(12)
            make.left.equalTo(contentView).offset(12)
        }

        stackOfPhotos.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.left.equalTo(contentView).offset(12)
        }

        arrowImage.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-12)
            make.centerY.equalTo(photosLabel.snp.centerY)
        }
    }
    
    private func setupStackOfPhotos() {
        for index in 0...3 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: Photos.images[index])
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 6
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo((UIScreen.main.bounds.width - 48)/4)
                make.height.equalTo((UIScreen.main.bounds.width - 48)/4)
            }
            stackOfPhotos.addArrangedSubview(imageView)
        }

    }
    
}
