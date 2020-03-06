//
//  AlertPresenter.swift
//  OnrampProject
//
//  Created by Meagan Nolan on 3/5/20.
//

import UIKit

class AlertPresenter {

    let baseVC: UIViewController

    init(baseVC: UIViewController) {
        self.baseVC = baseVC
    }

    func showAlert(with title: String, with message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.baseVC.present(alertController, animated: true, completion: nil)
    }
}
