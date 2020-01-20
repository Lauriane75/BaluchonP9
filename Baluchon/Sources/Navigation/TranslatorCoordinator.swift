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

    private var initialTranslation = TranslationType.init(initialLanguage: (nameLanguage: "French", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))

    func start() {
        showTranslator(with: initialTranslation)
    }

    private func showTranslator(with parameter: TranslationType) {
        let client = HTTPClient()
        let repository = TranslatorRepository(client: client)
        let viewController = screens.createTranslatorViewController(with: parameter, repository: repository, delegate: self)
        presenter.viewControllers = [viewController]
    }

    private func showLanguageType(with type: LanguageType) {
        let viewController = screens.createSelectLanguagesViewController(languageType: type, delegate: self)
        presenter.show(viewController, sender: nil)
    }
}

extension TranslatorCoordinator: TranslatorViewModelDelegate {
    func showLanguageChoices(for type: LanguageType) {
        showLanguageType(with: type)
    }
}

extension TranslatorCoordinator: SelectLanguageViewModelDelegate {

    func didPressLanguageTypeButton(with languageType: SelectLanguageType) {
        presenter.popViewController(animated: true)
        switch languageType {
        case .request(let value, let key):
            initialTranslation.initialLanguage = (value, key, "")
        case .result(let value, let key):
            initialTranslation.destinationLanguage = (value, key, "")
        }
        showTranslator(with: initialTranslation)
    }
}

enum SelectLanguageType: Equatable {
    case request(_ value: String, _ key: String)
    case result(_ value: String, _ key: String)
}
