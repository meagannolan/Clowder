//
//  NetworkManager.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/2/20.
//

import UIKit
import CoreData

enum NetworkError: Error {
    case invalidURL
    case invalidHTTPResponse
    case invalidMimeType
    case invalidData
}

class NetworkManager {

    static let shared = NetworkManager()

    func fetchPhotos(for endpoint: Endpoint, completionHandler: @escaping([Photo], Error?) -> Void) {
        guard let urlRequest = endpoint.createURLRequest() else {
            completionHandler([], NetworkError.invalidURL)
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completionHandler([], error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completionHandler([], NetworkError.invalidHTTPResponse)
                    return
            }
            guard let mimeType = httpResponse.mimeType, mimeType == "application/json" else {
                completionHandler([], NetworkError.invalidMimeType)
                return
            }
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let photos = self.fetchOrCreatePhotos(from: json)
                DispatchQueue.main.async {
                    completionHandler(photos, nil)
                }
            } else {
                completionHandler([], NetworkError.invalidData)
            }
        }
        task.resume()

    }

    func fetchOrCreatePhotos(from data: [String: Any]) -> [Photo] {
        var photos: [Photo] = []
        guard let results = data["results"] as? [Any] else {
            return []
        }
        for object in results {
            if let photoDict = object as? [String: Any], let id = photoDict["id"] as? String {
                guard let photo = CoreDataManager.shared.fetchOrCreatePhoto(with: id) else { continue }
                photo.parse(data: photoDict)
                photos.append(photo)
            }
        }
        return photos
    }

    //should it be fetchimages? all at once?
    func fetchImage(from photo: Photo, completionHandler: @escaping(UIImage?, Error?) -> Void) {
        //TODO: fetch by size
        guard let url = URL(string: photo.urls["small"] as! String) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, NetworkError.invalidData)
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completionHandler(image, nil)
            }
        }
        task.resume()
    }
}

