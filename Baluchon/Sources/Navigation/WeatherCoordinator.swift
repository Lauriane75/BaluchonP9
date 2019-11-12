//
//  WeatherCoordinator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 22/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class WeatherCoordinator {

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
        let repository = WeatherRepository(client: client)
        let viewController = screens.createMainViewController(repository: repository)
        presenter.viewControllers = [viewController]
    }
}

extension WeatherCoordinator: WeatherViewControllerDelegate {

}
