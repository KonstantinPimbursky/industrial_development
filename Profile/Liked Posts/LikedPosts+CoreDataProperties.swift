//
//  LikedPosts+CoreDataProperties.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 06.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension LikedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPost> {
        return NSFetchRequest<LikedPost>(entityName: "LikedPost")
    }

    @NSManaged public var id: UUID
    @NSManaged public var postAuthor: String
    @NSManaged public var postDescription: String
    @NSManaged public var postImage: String
    @NSManaged public var postLikes: Int16
    @NSManaged public var postViews: Int16

}

extension LikedPost : Identifiable {

}
