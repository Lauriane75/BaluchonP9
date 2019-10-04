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
        let weatherViewController = screens.createWeatherViewController(delegate: self)
        presenter.rootViewController?.show(weatherViewController, sender: nil)
    }
    
    private func showConverter() {
        let converterViewController = screens.createConverterViewController(delegate: self)
        presenter.rootViewController?.show(converterViewController, sender: nil)
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
        showConverter()
    }
}



extension MainCoordinator: WeatherViewControllerDelegate {

}

extension MainCoordinator: ConverterViewControllerDelegate {

}

extension MainCoordinator: TranslatorViewControllerDelegate {
    func didPressbackToMenu() {
        presenter.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

