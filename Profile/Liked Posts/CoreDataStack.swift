//
//  CoreData.swift
//  Navigation
//
//  Created by Konstantin Pimbursky on 06.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import CoreData

class CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "LikedPostsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func fetchLikedPosts() -> [LikedPosts] {
        let request: NSFetchRequest<LikedPosts> = LikedPosts.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("🤷‍♂️ Что-то пошло не так..")
        }
    }
    
    func remove(likedPost: LikedPosts) {
        viewContext.delete(likedPost)
        
        save(context: viewContext)
    }
    
    func createNewLikedPost(post: PostModel) {
        let newLikedPost = LikedPosts(context: viewContext)
        newLikedPost.id = UUID()
        newLikedPost.postAuthor = post.author
        newLikedPost.postDescription = post.description
        newLikedPost.postImage = post.image
        newLikedPost.postLikes = Int16(post.likes)
        newLikedPost.postViews = Int16(post.views)
        
        
        save(context: viewContext)
    }
    
    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
