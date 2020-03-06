//
//  FavoritePhotosViewController.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/3/20.
//

import UIKit

class FavoritePhotosViewController: UIViewController {

    private let viewModel = PhotosViewModel()

    var photos: [Photo] = [] {
        didSet {
            photos.isEmpty ? showEmptyState() : configureCollectionView()
        }
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var emptyStateView = EmptyStateView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bind()
        viewModel.fetchFavoritePhotos()
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    private func bind(){
        self.viewModel.didUpdate = { _ in
            self.viewModelDidUpdate()
        }
    }

    private func viewModelDidUpdate(){
        viewModel.photos.isEmpty ? showEmptyState() : configureCollectionView()
    }

    private func configureCollectionView() {
        if !view.subviews.contains(collectionView) {
            view.addSubview(collectionView)
            let safeArea = view.safeAreaLayoutGuide
            collectionView.constrainTo(safeArea, with: UIEdgeInsets(top: 20, left: 20, bottom: -20, right: -20))
        }
        collectionView.reloadData()
    }

    private func showEmptyState() {
        view.addSubview(emptyStateView)
        let safeArea = view.safeAreaLayoutGuide
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 50),
            emptyStateView.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -50),
            emptyStateView.heightAnchor.constraint(equalToConstant: 250),
            emptyStateView.widthAnchor.constraint(equalTo: emptyStateView.heightAnchor, multiplier: 1)
        ])
    }
}

extension FavoritePhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = viewModel.photos[indexPath.row]
        let photoViewModel = PhotoViewModel(photo)
        cell.configure(with: photoViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.row]
        let photoViewModel = PhotoViewModel(photo)
        let photoDetailVC = PhotoDetailViewController(photoViewModel)
        present(photoDetailVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 4.5
        let width = (collectionView.frame.width / 3) - padding
        return CGSize(width: width, height: width)
    }
}
