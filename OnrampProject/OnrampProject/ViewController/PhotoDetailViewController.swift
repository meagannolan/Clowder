//
//  PhotoDetailViewController.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    private let photo: Photo

    private let closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        button.tintColor = .white
        return button
    }()

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let actionStackView = ActionStackView()

    private lazy var alertPresenter = AlertPresenter(baseVC: self)

    init(_ photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.fetchImage(from: photo) { (image, error) in
            DispatchQueue.main.async {
                self.photoImageView.image = image
                self.actionStackView.favoriteButton.isSelected = self.photo.isFavorite
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(closeButton)
        view.addSubview(photoImageView)
        view.addSubview(actionStackView)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30)
        ])

        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(greaterThanOrEqualTo: closeButton.bottomAnchor, constant: 50),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            actionStackView.heightAnchor.constraint(equalToConstant: 40),
            actionStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            actionStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            actionStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -20)
        ])

        actionStackView.delegate = self
    }

    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoDetailViewController: ActionStackViewDelegate {

    func favoriteButtonDidTap(_ view: UIStackView, _ isSelected: Bool) {
        photo.isFavorite = isSelected
        do {
            try CoreDataManager.shared.context.save()
        } catch {
            NSLog("Favorite failed to save")
        }
    }

    func downloadButtonDidTap(_ view: UIStackView) {
        guard let image = photoImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(downloadedImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func downloadedImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            alertPresenter.showAlert(with: "Error", with: error.localizedDescription)
        } else {
            alertPresenter.showAlert(with: "Success", with: "Saved to your photos!")
        }
    }
}
