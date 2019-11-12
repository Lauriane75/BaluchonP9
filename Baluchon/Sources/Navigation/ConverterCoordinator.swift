//
//  ConverterCoordinator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 22/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class ConverterCoordinator {

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
        showConverter()
    }

    private func showConverter() {
        let client = HTTPClient()
        let repository = ConverterRepository(client: client)
        let viewController = screens.createConverterViewController(repository: repository)
        presenter.viewControllers = [viewController]
    }
}

