//
//  File.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/4/20.
//

import UIKit

class PhotoViewModel: NSObject {

    let photo: Photo
    var isFavorite: Bool {
        didSet {
            photo.isFavorite = isFavorite
        }
    }
    var didUpdate: ((PhotoViewModel) -> Void)?
    var favoritingDidThrowError: (() -> Void)?
    var didDownload: ((Bool) -> Void)?
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

    func didUpdateFavorite() {
        do {
            try CoreDataManager.shared.context.save()
            self.didUpdate?(self)
        } catch {
            self.favoritingDidThrowError?()
        }
    }

    func download() {
        guard let downloadImage = image else { return }
        UIImageWriteToSavedPhotosAlbum(downloadImage, self, #selector(downloadedImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func downloadedImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            self.didDownload?(true)
        }
    }
}
