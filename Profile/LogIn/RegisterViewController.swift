//
//  RegisterViewController.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 30.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textColor = .black
        return label
    }()
    
    private let emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .none
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.tintColor = UIColor.init(named: "accentColor")
        textField.placeholder = "Email or phone"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .none
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.tintColor = UIColor.init(named: "accentColor")
        textField.placeholder = "Password"
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let loginPasswordView: UIView = {
        let someView = UIView()
        someView.clipsToBounds = true
        someView.backgroundColor = .systemGray6
        someView.layer.cornerRadius = 10
        someView.layer.borderColor = UIColor.lightGray.cgColor
        someView.layer.borderWidth = 0.5
        return someView
    }()
    
    private let lineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = .lightGray
        return someView
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .automatic
        return scroll
    }()
    
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(registerLabel)
        contentView.addSubview(loginPasswordView)
        contentView.addSubview(logInButton)
        contentView.addSubview(emailOrPhoneTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(lineView)
        
        setupViews()
    }
    
    @objc private func logInButtonPressed() {
        if let login = emailOrPhoneTextField.text,
           let password = passwordTextField.text {
            self.delegate?.saveLoginPassword(login: login, password: password)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupViews() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        registerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
        
        loginPasswordView.snp.makeConstraints { make in
            make.top.equalTo(registerLabel.snp.bottom).offset(120)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(100)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(loginPasswordView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(loginPasswordView.snp.centerY)
            make.left.equalTo(loginPasswordView)
            make.right.equalTo(loginPasswordView)
            make.height.equalTo(0.5)
        }
        
        emailOrPhoneTextField.snp.makeConstraints { make in
            make.left.equalTo(loginPasswordView).offset(10)
            make.right.equalTo(loginPasswordView).offset(-10)
            make.centerY.equalTo(loginPasswordView).offset(-25)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(loginPasswordView).offset(10)
            make.right.equalTo(loginPasswordView).offset(-10)
            make.centerY.equalTo(loginPasswordView).offset(25)
        }
    }
    
    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

}
