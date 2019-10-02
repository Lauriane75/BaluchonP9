//
//  MainCoordinator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class MainCoordinator {

    private let presenter: UIWindow

    private let screens: Screens

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter
        self.screens = Screens(context: context)
    }

    func start() {
        showMain()
    }

    private func showMain() {
        let mainViewController = screens.createMainViewController(delegate: self)
        presenter.rootViewController = mainViewController
    }

    private func showTranslator() {
        let translatorViewController = screens.createTranslatorViewController(delegate: self)
        presenter.rootViewController?.show(translatorViewController, sender: nil)
    }
    
    private func showWeather() {
        let translatorViewController = screens.createTranslatorViewController(delegate: self)
        presenter.rootViewController?.show(translatorViewController, sender: nil)
    }
    
    private func showCurrency() {
        let translatorViewController = screens.createCurrencyViewController(delegate: self)
        presenter.rootViewController?.show(translatorViewController, sender: nil)
    }
}

extension MainCoordinator: MainViewControllerDelegate {

    func didPressTranslatorButton() {
        showTranslator()
    }
    func didPressWeatherButton() {
        showWeather()
    }
    func didPressConverterButton() {
        showCurrency()
    }
}

extension MainCoordinator: WeatherViewControllerDelegate {

}

extension MainCoordinator: ConverterViewControllerDelegate {

}

extension MainCoordinator: TranslatorViewControllerDelegate {
    func backToMenu() {
        presenter.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

