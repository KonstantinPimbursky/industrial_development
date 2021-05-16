//
//  NetworkService.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 13.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

 struct NetworkService {

     private static let session = URLSession.shared
     static let shared = NetworkService()

     private init() {

     }

     static func dataTask(url: URL, completion: @escaping (String?) -> Void) {
         let task = session.dataTask(with: url) { data, responce, error in
             guard error == nil else {
                 ///При выключенном интернете, возвращается код ошибки -1009 "The Internet connection appears to be offline."
                 print(error.debugDescription)
                 return
             }
             guard let httpResponce = responce as? HTTPURLResponse,
                   httpResponce.statusCode == 200 else { return }
             print("Reseponce all header fields: ", httpResponce.allHeaderFields)
             print("Responce status code: ", httpResponce.statusCode)
             if let data = data {
                 completion(String(data: data, encoding: .utf8))
             }
         }
         task.resume()
     }
    
    static func getDataForPostModel (url: URL, completion: @escaping ([String:Any]?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else { return }
            if let dict = data {
                let dictionary = try! JSONSerialization.jsonObject(with: dict, options: .mutableContainers) as! [String: Any]
                completion(dictionary)
            }
        }
        task.resume()
    }
    
    static func getDataForPlanetModel (url: URL, completion: @escaping (Data?) -> Void) {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else { return }
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
 }
