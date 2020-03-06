//
//  PhotosViewModel.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/4/20.
//

import Foundation

class PhotosViewModel {

    private let endpoint = Endpoint()
    var photos: [Photo] = []
    var photoViewModels: [PhotoViewModel] = []
    var didUpdate: ((PhotosViewModel) -> Void)?

    func fetchPhotos() {
        NetworkManager.shared.fetchPhotos(for: endpoint) { (photos, error) in
            guard error == nil else { return }
            self.photos = photos
            self.photoViewModels = photos.map { self.viewModelForPhoto(photo: $0) }
            self.didUpdate?(self)
        }
    }

    func fetchFavoritePhotos() {
        self.photos = CoreDataManager.shared.fetchFavoritePhotos()
        self.photoViewModels = photos.map { self.viewModelForPhoto(photo: $0) }
        self.didUpdate?(self)
    }

    func viewModelForPhoto(photo: Photo) -> PhotoViewModel {
        let viewModel = PhotoViewModel(photo)
        return viewModel
    }
}
