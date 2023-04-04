//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Nikita Byzov on 18.11.2022.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init(){
        reloadData()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "note")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror.localizedDescription), \(nserror.userInfo)")
            }
        }
    }
    
    var posts = [Posts]()
    
    func reloadData(){
        let request = Posts.fetchRequest()
        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.posts = posts
    }
    
    func createPost(title: String, image: String, author: String, description: String, likes: Int, views: Int, id: String){
        persistentContainer.performBackgroundTask({ contexBackground in
            let newPost = Posts(context: contexBackground)
            newPost.title = title
            newPost.image = image
            newPost.author = author
            newPost.descriptionOfPost = description
            newPost.likes = Int16(likes)
            newPost.view = Int16(views)
            newPost.id = id
            try? contexBackground.save()
            DispatchQueue.main.async {
                self.reloadData()
            }
        })
    }
    
    func deletePostTypeNote(post: Posts){
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadData()
    }
    
    func getPostsBy(author: String) -> [Posts] {
        let fetchRequest = Posts.fetchRequest()
        if author != "" {
            fetchRequest.predicate = NSPredicate(format: "author CONTAINS[c] %@", author)
        }
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
