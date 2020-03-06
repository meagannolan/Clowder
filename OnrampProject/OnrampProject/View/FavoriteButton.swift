//
//  FavoriteButton.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/4/20.
//

import UIKit

class FavoriteButton: UIButton {

    override var isSelected: Bool {
        didSet {
            tintColor = isSelected ? .red : .white
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        tintColor = .white
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageView?.contentMode = .scaleAspectFit
    }
}
