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

    // ici mon presenter sera ma tab bar

//    var navigationController: UINavigationController

    private let screens: Screens

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter
        self.screens = Screens(context: context)
//        self.navigationController = navigationController
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
    
    private func showConverter() {
        let converterViewController = screens.createConverterViewController(delegate: self)
        presenter.rootViewController?.show(converterViewController, sender: nil)
    }
}

extension MainCoordinator: WeatherViewControllerDelegate {

    func didPressTranslatorButton() {
        showTranslator()
    }
    func didPressConverterButton() {
        showConverter()
    }
}


extension MainCoordinator: ConverterViewControllerDelegate {

}

extension MainCoordinator: TranslatorViewControllerDelegate {

}

