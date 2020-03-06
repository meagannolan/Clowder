//
//  PhotoCell.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1),
        ])
    }
    
    func configure(with photo: Photo) {
        NetworkManager.shared.fetchImage(from: photo) { (image, error) in
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
}
