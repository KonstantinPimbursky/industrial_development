//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func signIn (email: String, password: String) -> Void
    func signOut () -> Void
    func createUser (email: String, password: String) -> Void
}
