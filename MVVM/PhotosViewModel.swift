//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 29.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol PhotosViewOutput {
    func givePhotos(_ number: Int) -> String
    func countOfPhotos() -> Int
}

class PhotosViewModel: PhotosViewOutput {
    
    func givePhotos(_ number: Int) -> String {
        return Photos.images[number]
    }
    
    func countOfPhotos() -> Int {
        return Photos.images.count
    }
}
