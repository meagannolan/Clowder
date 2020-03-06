//
//  ActionStackView.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/4/20.
//

import UIKit

protocol ActionStackViewDelegate: class {
    func favoriteButtonDidTap(_ view: UIStackView, _ isSelected: Bool)
    func downloadButtonDidTap(_ view: UIStackView)
}

class ActionStackView: UIStackView {

    private let downloadButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.down.to.line", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let favoriteButton: FavoriteButton = {
        let button = FavoriteButton()
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate: ActionStackViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addArrangedSubview(downloadButton)
        addArrangedSubview(favoriteButton)
        distribution = .fillEqually
        axis = .horizontal
    }

    @objc private func favoriteButtonTapped() {
        favoriteButton.isSelected = !favoriteButton.isSelected
        delegate?.favoriteButtonDidTap(self, favoriteButton.isSelected)
    }

    @objc private func downloadButtonTapped() {
        delegate?.downloadButtonDidTap(self)
    }
}
