//
//  CoreDataManager.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {

    var context: NSManagedObjectContext!
    static let shared: CoreDataManager = CoreDataManager()

    class func setUpCoreDataStack() {
        let container = NSPersistentContainer(name: "OnRampProject")
        container.loadPersistentStores { (store, error) in
            guard error == nil else { NSLog("Failed to load core data stack!"); return }
            shared.context = container.viewContext
            NSLog("Loaded store!")
        }
    }

    func fetchOrCreatePhoto(with id: String) -> Photo? {
        var fetchedPhoto: Photo? = nil
        guard let context = CoreDataManager.shared.context else { return nil }
        let request = NSFetchRequest<Photo>(entityName: "Photo")
        request.predicate = NSPredicate(format: "id == %@", id)
        context.performAndWait() {
            do {
                let fetchedPhotos = try context.fetch(request)
                if let photo = fetchedPhotos.first {
                    fetchedPhoto = photo
                } else {
                    guard let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as? Photo else { return }
                    photo.id = id
                    fetchedPhoto = photo
                }
            } catch {
                NSLog("Failed to fetch photos")
            }
        }
        return fetchedPhoto
    }
    
    func fetchFavoritePhotos() -> [Photo] {
        var photos: [Photo] = []
        let context = CoreDataManager.shared.context
        let request = NSFetchRequest<Photo>(entityName: "Photo")
        request.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        context?.performAndWait() {
            do {
                if let fetchedPhotos = try context?.fetch(request) {
                    photos = fetchedPhotos
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return photos
    }
}
