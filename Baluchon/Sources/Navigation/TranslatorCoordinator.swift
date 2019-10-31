//
//  TranslatorCoordinator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 22/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class TranslatorCoordinator {

    // MARK: - Properties

    private let presenter: UINavigationController

    private let screens: Screens

    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }

    // MARK: - Coodinator

    private var defaultTranslation = TranslationType.init(originLanguage: (nameLanguage: "French", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))


    func start() {
        showTranslator(with: defaultTranslation)
    }

    private func showTranslator(with parameter: TranslationType) {
        let client = HTTPClient()
        let repository = TranslatorRepository(client: client)
        let viewController = screens.createTranslatorViewController(with: parameter, repository: repository, delegate: self)
        presenter.viewControllers = [viewController]
    }

//    private func showAlert(for type: AlertType) {
//        let alert = screens.
//        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
//    }




}

extension TranslatorCoordinator: TranslatorViewControllerDelegate {

//    func presentAlert(f) {
//    }

}

