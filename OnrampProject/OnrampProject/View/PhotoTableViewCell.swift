//
//  PhotoTableViewCell.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout()  {
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
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
