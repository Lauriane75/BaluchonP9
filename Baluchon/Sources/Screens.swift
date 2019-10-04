//
//  Screens.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation


import UIKit

final class Screens {

    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))

    let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK : - Main

protocol MainViewControllerDelegate: class {
    func didPressTranslatorButton()
    func didPressWeatherButton()
    func didPressConverterButton()
}

extension Screens {
    func createMainViewController(delegate: MainViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let viewModel = MainViewModel(delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Child

protocol TranslatorViewControllerDelegate: class {
    func didPressbackToMenu()
}

protocol WeatherViewControllerDelegate: class {
    func didPressbackToMenu()
}

protocol ConverterViewControllerDelegate: class {
    func didPressbackToMenu()
}

extension Screens {
    func createTranslatorViewController(delegate: TranslatorViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TranslatorViewController") as! TranslatorViewController
        let repository = TranslatorRepository(client: context.client)
        let viewModel = TranslatorViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }

    func createWeatherViewController(delegate: WeatherViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        let repository = WeatherRepository(client: context.client)
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }

    func createConverterViewController(delegate: ConverterViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConverterViewController") as! ConverterViewController
        let repository = ConverterRepository(client: context.client)
        let viewModel = ConverterViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}
