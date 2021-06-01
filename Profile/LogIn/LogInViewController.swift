//
//  LogInViewController.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 26.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .none
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "logo")
        return imageView
    }()
    
    private let emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Log In", for: .normal)
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
        someView.translatesAutoresizingMaskIntoConstraints = false
        someView.clipsToBounds = true
        someView.backgroundColor = .systemGray6
        someView.layer.cornerRadius = 10
        someView.layer.borderColor = UIColor.lightGray.cgColor
        someView.layer.borderWidth = 0.5
        return someView
    }()
    
    private let lineView: UIView = {
        let someView = UIView()
        someView.translatesAutoresizingMaskIntoConstraints = false
        someView.backgroundColor = .lightGray
        return someView
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentInsetAdjustmentBehavior = .automatic
        return scroll
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let registerNewAccoutButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(.systemGray, for: .normal)
        button.addTarget(self, action: #selector(registerNewAccountButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var delegate: LoginViewControllerDelegate?
    
    private var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginPasswordView)
        contentView.addSubview(logInButton)
        contentView.addSubview(emailOrPhoneTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(lineView)
        contentView.addSubview(registerNewAccoutButton)
        
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
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        loginPasswordView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(120)
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
            make.centerY.equalTo(loginPasswordView)
            make.left.equalTo(loginPasswordView)
            make.right.equalTo(loginPasswordView)
            make.height.equalTo(0.5)
        }
        
        emailOrPhoneTextField.snp.makeConstraints { make in
            make.centerY.equalTo(loginPasswordView.snp.centerY).offset(-25)
            make.left.equalTo(loginPasswordView.snp.left).offset(10)
            make.right.equalTo(loginPasswordView.snp.right).offset(-10)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerY.equalTo(loginPasswordView.snp.centerY).offset(25)
            make.left.equalTo(loginPasswordView.snp.left).offset(10)
            make.right.equalTo(loginPasswordView.snp.right).offset(-10)
        }
        
        registerNewAccoutButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func logInButtonPressed () {
        checkLoginPassword { result in
            switch result {
            case .success(_):
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as UIViewController
                navigationController?.pushViewController(profileViewController, animated: true)
            case .failure(_):
                let alertController = UIAlertController(title: "Ошибка", message: "Неверно введен логин или пароль", preferredStyle: .alert)
                let acceptAction = UIAlertAction(title: "ОК", style: .default)
                alertController.addAction(acceptAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func registerNewAccountButtonPressed() {
        let registerViewController = RegisterViewController()
        registerViewController.delegate = self.delegate
        present(registerViewController, animated: true, completion: nil)
    }
    
    private func checkLoginPassword(completion: (Result<Bool,LoginPasswordError>) -> Void)  {
        if let email = emailOrPhoneTextField.text,
           let password = passwordTextField.text {
            if self.delegate!.checkLoginPassword(login: email, password: password) {
                return completion(.success(true))
            } else {
                return completion(.failure(LoginPasswordError.incorrectLoginOrPassword))
            }
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

extension UIImage {
func alpha(_ value:CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
    }
}
