//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func checkLoginPassword (login: String, password: String) -> Bool
    func saveLoginPassword (login: String, password: String) -> Void
    func checkAuth () -> Bool
}
