//
//  CatPhoto.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/2/20.
//

import Foundation
import CoreData

enum ImageSize {
    case small
    case large
}

@objc(Photo)

class Photo: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var width: Int32
    @NSManaged var height: Int32
    @NSManaged var smallImageURL: String
    @NSManaged var largeImageURL: String
    @NSManaged var author: String
    @NSManaged var isFavorite: Bool

    func parse(data: [String: Any]) {
        if let id = data["id"] as? String {
            self.id = id
        }
        if let width = data["width"] as? Int32 {
            self.width = width
        }
        if let height = data["height"] as? Int32 {
            self.height = height
        }
        if let urls = data["urls"] as? [String: Any] {
            if let smallImageURL = urls["small"] as? String {
                self.smallImageURL = smallImageURL
            }
            if let largeImageURL = urls["regular"] as? String {
                self.largeImageURL = largeImageURL
            }
        }
        if let author = data["name"] as? String {
            self.author = author
        }
    }
}
