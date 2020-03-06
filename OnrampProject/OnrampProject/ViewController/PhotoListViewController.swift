//
//  ViewController.swift
//  OnrampProject
//
//  Created by Giovanni Noa on 2/20/20.
//

import UIKit

class PhotoListViewController: UIViewController {

    var photos: [Photo] = []
    private let endpoint = Endpoint()
    private let viewModel = PhotosViewModel()

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
        endpoint.page = 1
        self.bind()
        viewModel.fetchPhotos()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
    }

    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        let safeArea = view.safeAreaLayoutGuide
        tableView.constrainTo(safeArea)
    }

    private func bind(){
        self.viewModel.didUpdate = { _ in
            self.viewModelDidUpdate()
        }
    }

    private func viewModelDidUpdate(){
        self.tableView.reloadData()
    }

}
extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let photoViewModel = viewModel.photoViewModels[indexPath.row]
        cell.configure(with: photoViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoViewModel = viewModel.photoViewModels[indexPath.row]
        let photoDetailVC = PhotoDetailViewController(photoViewModel)
        present(photoDetailVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            endpoint.page += 1
            NetworkManager.shared.fetchPhotos(for: endpoint) { (photos, error) in
                guard error == nil else { return }
                self.photos += photos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
