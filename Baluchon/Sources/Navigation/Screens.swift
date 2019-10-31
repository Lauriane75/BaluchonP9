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

protocol WeatherViewControllerDelegate: class {
}

extension Screens {

    func createMainViewController(repository: WeatherRepository, delegate: WeatherViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        let repository = WeatherRepository(client: context.client)
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Child

protocol TranslatorViewControllerDelegate: class {
}

protocol ConverterViewControllerDelegate: class {
}

extension Screens {
    func createTranslatorViewController(with translationType: TranslationType, repository: TranslatorRepository, delegate: TranslatorViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TranslatorViewController") as! TranslatorViewController
        let repository = TranslatorRepository(client: context.client)
        let viewModel = TranslatorViewModel(repository: repository, delegate: delegate, translationType: translationType)
        viewController.viewModel = viewModel
        return viewController
    }

    func createConverterViewController(repository: ConverterRepository, delegate: ConverterViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConverterViewController") as! ConverterViewController
        let repository = ConverterRepository(client: context.client)
        let viewModel = ConverterViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}
