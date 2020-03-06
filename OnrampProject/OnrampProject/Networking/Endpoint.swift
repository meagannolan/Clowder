//
//  CatEndpoint.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/2/20.
//

import Foundation

class Endpoint {

    let scheme: String
    let host: String
    let path: String
    var page: Int {
        didSet {
            if queryItems.count > 1 { queryItems.removeLast() }
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
    }
    var queryItems: [URLQueryItem]

    init(_ scheme: String = "https", _ host: String = "api.unsplash.com", _ path: String = "/search/photos", _ page: Int = 1) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.page = page
        self.queryItems = [URLQueryItem(name: "query", value: "cat"), URLQueryItem(name: "page", value: "\(page)")]
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    func createURLRequest() -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        request.setValue("Client-ID BrXzPU8xcCxdVxIYx2yzpD9Uk8m3dnQMY2g4QrVKwU0", forHTTPHeaderField: "Authorization")
        return request
    }
}
