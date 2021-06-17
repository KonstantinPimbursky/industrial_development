//
//  LoginInspector.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func checkLogin(login: String?) -> Bool {
        return LoginChecker.shared.checkLoginPassword(login: login, password: nil)
    }
    
    func checkPassword(password: String?) -> Bool {
        return LoginChecker.shared.checkLoginPassword(login: nil, password: password)
    }
}
