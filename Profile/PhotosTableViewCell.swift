//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 08.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

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
        let constraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            stackOfPhotos.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            stackOfPhotos.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackOfPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupStackOfPhotos() {
        for index in 0...3 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: Photos.images[index])
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 6
            imageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4).isActive = true
            stackOfPhotos.addArrangedSubview(imageView)
        }

    }
    
}
