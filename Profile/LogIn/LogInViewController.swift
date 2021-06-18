//
//  LogInViewController.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 26.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    
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
    
    var delegate: LoginViewControllerDelegate?
    
    private let bruteForceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(bruteForceStart), for: .touchUpInside)
        return button
    }()
    
    private var password: String = ""
    
    private let dispatchQueue = DispatchQueue(label: "Background", qos: .background, attributes: .concurrent)
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

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
        contentView.addSubview(bruteForceButton)
        contentView.addSubview(activityIndicator)
        
        let contraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
                        
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loginPasswordView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginPasswordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginPasswordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginPasswordView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: loginPasswordView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            bruteForceButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            bruteForceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            activityIndicator.leadingAnchor.constraint(equalTo: bruteForceButton.trailingAnchor, constant: 8),
            activityIndicator.centerYAnchor.constraint(equalTo: bruteForceButton.centerYAnchor),
            
            lineView.centerYAnchor.constraint(equalTo: loginPasswordView.centerYAnchor),
            lineView.leadingAnchor.constraint(equalTo: loginPasswordView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: loginPasswordView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            emailOrPhoneTextField.leadingAnchor.constraint(equalTo: loginPasswordView.leadingAnchor, constant: 10),
            emailOrPhoneTextField.trailingAnchor.constraint(equalTo: loginPasswordView.trailingAnchor, constant: -10),
            emailOrPhoneTextField.centerYAnchor.constraint(equalTo: loginPasswordView.centerYAnchor, constant: -25),
            
            passwordTextField.leadingAnchor.constraint(equalTo: loginPasswordView.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: loginPasswordView.trailingAnchor, constant: -10),
            passwordTextField.centerYAnchor.constraint(equalTo: loginPasswordView.centerYAnchor, constant: 25)
        ]
        
        NSLayoutConstraint.activate(contraints)
        
    }
    
    @objc func logInButtonPressed () {
        checkLoginPassword { result in
            switch result {
            case .success(_):
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                profileViewController.coreDataStack = coreDataStack
                navigationController?.pushViewController(profileViewController, animated: true)
            case .failure(_):
                let alertController = UIAlertController(title: "Ошибка", message: "Неверно введен логин или пароль", preferredStyle: .alert)
                let acceptAction = UIAlertAction(title: "ОК", style: .default)
                alertController.addAction(acceptAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func checkLoginPassword(completion: (Result<Bool,LoginPasswordError>) -> Void)  {
        if self.delegate!.checkLogin(login: emailOrPhoneTextField.text) &&
            self.delegate!.checkPassword(password: passwordTextField.text) {
            return completion(.success(true))
        } else {
            return completion(.failure(LoginPasswordError.incorrectLoginOrPassword))
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
    
    @objc private func bruteForceStart() {
        dispatchQueue.async {
            self.startActivityIndicator()
            let allowedCharacters: [String] = String().printable.map { String($0) }

            while !LoginChecker.shared.checkLoginPassword(login: nil,
                                                          password: self.password) {
                self.password = self.generateBruteForce(self.password, fromArray: allowedCharacters)
                print(self.password)
            }
            self.passwordTransfer(password: self.password)
        }
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
    
    private func passwordTransfer(password: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.passwordTextField.isSecureTextEntry = false
            self.passwordTextField.text = password
        }
    }
        
    private func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
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

extension String {
    var digits: String {
        return "0123456789"
    }
    var lowercase: String {
        return "abcdefghijklmnopqrstuvwxyz"
    }
    var uppercase: String {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    }
    var punctuation: String {
        return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    }
    var letters: String {
        return lowercase + uppercase
    }
    var printable: String {
        return digits + letters + punctuation
    }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
