//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 06.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

enum AppConfiguration: CaseIterable {
    static var allCases: [AppConfiguration] = [
        .people("https://swapi.dev/api/people/\(Int.random(in: 1...82))"),
        .starships("https://swapi.dev/api/starships/\(Int.random(in: 1...36))"),
        .planets("https://swapi.dev/api/planets/\(Int.random(in: 1...60))")]
    
    case people(String)
    case starships(String)
    case planets(String)
    
    static func random() -> AppConfiguration {
        return allCases.randomElement()!
    }
}
