//
//  ViewController.swift
//  OnrampProject
//
//  Created by Giovanni Noa on 2/20/20.
//

import UIKit

class PhotoListViewController: UIViewController {

    var photos: [Photo] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoTableViewCell")
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.shared.fetchPhotos(for: Endpoint(page: 1)) { (photos, error) in
            self.photos = photos
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
    }

    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        let safeArea = view.safeAreaLayoutGuide
        tableView.constrainTo(safeArea)
    }

}
extension PhotoListViewController: UITableViewDataSource, UITableViewDataSourcePrefetching, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let photoDetailVC = PhotoDetailViewController(photo)
        present(photoDetailVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {

    }
}


//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let photo = photos[indexPath.row]
//        let rowWidth = tableView.frame.width
//        let photoAspectRatio = CGFloat(photo.height / photo.width)
//        return rowWidth * photoAspectRatio
//    }
