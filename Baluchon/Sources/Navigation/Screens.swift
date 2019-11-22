//
//  Screens.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

enum NextScreen: Equatable {
    case alert(title: String, message: String)
}

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


extension Screens {
    func createTranslatorViewController(with translationType: TranslationType, repository: TranslatorRepository, delegate: TranslatorViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TranslatorViewController") as! TranslatorViewController
        let repository = TranslatorRepository(client: context.client)
        let viewModel = TranslatorViewModel(repository: repository, translationType: translationType, delegate: delegate!)
        viewController.viewModel = viewModel
        return viewController
    }

    func createConverterViewController(repository: ConverterRepository) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConverterViewController") as! ConverterViewController
        let repository = ConverterRepository(client: context.client)
        let viewModel = ConverterViewModel(repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createSelectLanguagesViewController(languageType: LanguageType, delegate: SelectLanguageViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as! SelectLanguagesViewController
        let repository = SelectLanguageRepository()
        let viewModel = SelectLanguageViewModel(languageType: languageType,
                                          repository: repository,
                                          delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}
