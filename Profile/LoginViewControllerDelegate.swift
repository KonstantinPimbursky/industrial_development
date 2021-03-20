//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate: class {
    func checkLogin (login: String) -> Bool
    func checkPassword (password: String) -> Bool
}
