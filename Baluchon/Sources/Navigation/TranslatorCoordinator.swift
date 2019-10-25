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

    func start() {
        showHome()
    }

    private func showHome() {
        let client = HTTPClient()
        let repository = TranslatorRepository(client: client)
        let viewController = screens.createTranslatorViewController(repository: repository, delegate: self)
        presenter.viewControllers = [viewController]
    }


}

extension TranslatorCoordinator: TranslatorViewControllerDelegate {

}

