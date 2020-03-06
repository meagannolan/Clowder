//
//  CatEndpoint.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/2/20.
//

import Foundation

struct Endpoint {

    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]

    init(_ scheme: String = "https", _ host: String = "api.unsplash.com", path: String = "/search/photos", page: Int) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "query", value: "cat")]
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
