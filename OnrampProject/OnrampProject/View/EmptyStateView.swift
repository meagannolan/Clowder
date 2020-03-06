//
//  EmptyStateView.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

class EmptyStateView: UIView {

    private let label: UILabel = {
         let label = UILabel()
         label.textColor = .darkGray
         label.text = "Hmm, no favorites yet."
         label.adjustsFontSizeToFitWidth = true
         return label
     }()

     private let imageView: UIImageView = {
         let imageView = UIImageView()
         let image = UIImage(named: "thinking-cat")
         imageView.image = image
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        addSubview(label)
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 135),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ])

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
}
