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
    var jsonPost: JsonPostModel?
    private var dataForJson: [String : Any]?
    static let shared = InfoViewModel()
    
    private init() {
        
    }
    
    func getDataForJson() {
        NetworkService.getDataForPostJson(url: postUrl) { dictionary in
            self.dataForJson = dictionary
        }
    }

    func getPostJson() {
        self.jsonPost = JsonPostModel(userIdentifier: self.dataForJson?["userId"] as! Int,
                                         identifier: self.dataForJson?["id"] as! Int,
                                         title: self.dataForJson?["title"] as! String,
                                         completed: self.dataForJson?["completed"] as! Bool)
    }

}
