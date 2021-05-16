//
//  InfoViewModel.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 13.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewModel {
    
    private let postUrl = URL(string: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...200))")!
    private let planetUrl = URL(string: "https://swapi.dev/api/planets/1/")!
    private var dataForPostModel: [String : Any]?
    private var dataForPlanetModel: Data?
    var postModel: JsonPostModel?
    var planetModel: JsonPlanetModel?
    static let shared = InfoViewModel()
    
    private init() {
        
    }
    
    func getDataForPostModel() {
        NetworkService.getDataForPostModel(url: postUrl) { dictionary in
            self.dataForPostModel = dictionary
        }
    }

    func makePostModel() {
        self.postModel = JsonPostModel(userIdentifier: self.dataForPostModel?["userId"] as! Int,
                                         identifier: self.dataForPostModel?["id"] as! Int,
                                         title: self.dataForPostModel?["title"] as! String,
                                         completed: self.dataForPostModel?["completed"] as! Bool)
    }
    
    func getDataForPlanetModel() {
        NetworkService.getDataForPlanetModel(url: planetUrl) { data in
            self.dataForPlanetModel = data
        }
    }
    
    func makePlanetModel() {
        if let data = dataForPlanetModel {
            self.planetModel = try? JSONDecoder().decode(JsonPlanetModel.self, from: data)
        } else {
            print("Отсутствует JSON планеты")
        }
    }

}
