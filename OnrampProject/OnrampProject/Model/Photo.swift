//
//  CatPhoto.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/2/20.
//

import Foundation
import CoreData


@objc(Photo)

class Photo: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var width: Int32
    @NSManaged var height: Int32
    @NSManaged var urls: [String: Any]
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
            self.urls = urls
        }
        if let author = data["name"] as? String {
            self.author = author
        }
    }
}
