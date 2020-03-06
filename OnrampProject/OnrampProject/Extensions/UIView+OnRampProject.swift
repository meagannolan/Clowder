//
//  UIView+OnRampProject.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

extension UIView {

    func constrainTo(_ safeArea: UILayoutGuide, with padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: padding.bottom),
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: padding.right)
        ])
    }
}
