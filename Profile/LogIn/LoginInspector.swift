//
//  LoginInspector.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class LoginInspector: LoginViewControllerDelegate {
    
    let realm = try? Realm()
    
    func checkLoginPassword(login: String, password: String) -> Bool {
        guard let objects = realm?.objects(LoginPasswordRealmModel.self) else { return false }
        for value in objects {
            if value.login == login && value.password == password {
                do {
                    realm?.beginWrite()
                    value.authFlag = true
                    try realm?.commitWrite()
                } catch {
                    print(error.localizedDescription)
                }
                return true
            }
        }
        return false
    }
    
    func saveLoginPassword(login: String, password: String) {
        do {
            let loginPasswordModel = LoginPasswordRealmModel()
            loginPasswordModel.authFlag = false
            loginPasswordModel.login = login
            loginPasswordModel.password = password
            realm?.beginWrite()
            realm?.add(loginPasswordModel)
            try realm?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func checkAuth() -> Bool {
        guard let objects = realm?.objects(LoginPasswordRealmModel.self) else { return false }
        for value in objects {
            if value.authFlag {
                return true
            }
        }
        return false
    }

}
