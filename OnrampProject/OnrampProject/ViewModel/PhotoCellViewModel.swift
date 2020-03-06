//
//  PhotoViewModel.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

class PhotoViewModel {

    let photo: Photo
    var isFavorite: Bool
    var didUpdate: ((PhotoViewModel) -> Void)?
    var image: UIImage?

    init(_ photo: Photo) {
        self.photo = photo
        self.isFavorite = photo.isFavorite
    }

    func loadImage() {
        guard self.image == nil else { return }
        NetworkManager.shared.fetchImage(from: photo, size: .small) { (image, error) in
            self.image = image
            self.isFavorite = self.photo.isFavorite
            self.didUpdate?(self)
        }
    }

}
