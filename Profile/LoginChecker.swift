//
//  LoginChecker.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 20.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct Checker {
    
    static let shared = Checker()
    private let savedLogin = "Kostya"
    private let savedPassword = "kostya123@"
    
    private init() {
        
    }
    
    func checkLoginPassword (login: String, password: String) -> Bool {
        guard login == savedLogin && password == savedPassword else { return false }
        return true
    }
    
}
