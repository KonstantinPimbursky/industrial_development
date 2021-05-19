//
//  LoginInspector.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase

class LoginInspector: LoginViewControllerDelegate {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func signIn (email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                let alertController = self.showCreateUserAlertController(email: email, password: password)
                self.navigationController?.present(alertController, animated: true, completion: nil)
                return
            }
            let profileViewController = ProfileViewController()
            profileViewController.signOut = self.signOut
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    func signOut () {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            print(String(describing: try? Auth.auth().signOut()))
        }
    }
    
    func createUser (email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print("Не удалось создать пользователя")
                return
            }
        }
    }
    
    private func showCreateUserAlertController(email: String, password: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Неверно введен логин или пароль.\nСоздать нового пользователя?",
                                                preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Создать", style: .default) { [weak self] _ in
            if let strongSelf = self {
                strongSelf.createUser(email: email, password: password)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
}
