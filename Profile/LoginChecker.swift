//
//  LoginChecker.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct LoginChecker {
    
    static let shared = LoginChecker()
    private let savedLogin = "Kostya"
    private let savedPassword = "kostya123@"
    
    private init() {
        
    }
    
    func checkLoginPassword (login: String?) -> Bool {
        guard login != nil && login == savedLogin else { return false}
        return true
    }
    
    func checkLoginPassword (password: String?) -> Bool {
        guard password != nil && password == savedPassword else { return false }
        return true
    }
    
}
