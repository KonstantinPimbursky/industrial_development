//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 05.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    
    var signOut: (() -> Void)?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "white-oriental-cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100 / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "White Oriental Cat"
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        return textField
    }()
    
     private let setStatusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.setTitle("Установить статус", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.setTitle("Выход", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private var statusText = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(avatarImageView,
                    fullNameLabel,
                    statusLabel,
                    statusTextField,
                    setStatusButton,
                    signOutButton)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        guard statusLabel.text != nil else {
            return
        }
        statusLabel.text = statusText
        print(statusLabel.text!)
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        guard textField.text != nil else {
            return
        }
        statusText = textField.text!
    }
    
    @objc private func signOutButtonPressed() {
        self.signOut!()
    }
    
    private func setupViews() {
        signOutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(50)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(27)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(40)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(50)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-16)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(40)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.bottom.equalTo(statusTextField.snp.top).offset(-10)
        }

    }
    
}

