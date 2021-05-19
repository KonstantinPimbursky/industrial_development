//
//  LoginPasswordError.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 08.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

enum LoginPasswordError: Error {
    case acountNotAllowed
    case userDisabled
    case wrongPassword
    case invalidEmail
}
