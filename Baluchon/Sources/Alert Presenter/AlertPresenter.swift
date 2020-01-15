//
//  File.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 03/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation
import UIKit

class AlertPresenter {
    // MARK: - Alert
    func presentAlert(on viewController: UIViewController, with title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertView.addAction(okAction)
        viewController.present(alertView, animated: true, completion: nil)
    }
}

