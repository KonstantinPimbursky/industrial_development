//
//  LoginPasswordRealmModel.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 30.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class LoginPasswordRealmModel: Object {
    @objc dynamic var authFlag: Bool = false
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
}
