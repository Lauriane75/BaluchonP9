//
//  TranslatorViewModel.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

enum LanguageType {
    case request
    case result
}

protocol TranslatorViewModelDelegate: class {
    func showLanguageChoices(for type: LanguageType)
}

struct TranslationType {
    var initialLanguage: (nameLanguage: String, ISOCode: String, text: String)
    var destinationLanguage: (nameLanguage: String, ISOCode: String, text: String)
}

final class TranslatorViewModel {

    // MARK: - Properties

    private let repository: TranslatorRepositoryType

    private let translationType: TranslationType

    private weak var delegate: TranslatorViewModelDelegate?

    typealias LanguageParameters = (nameLanguage: String, ISOCode: String, text: String)

    // MARK: Private properties

    private var requestTranslationText = "" {
        didSet {
            requestTextField?(requestTranslationText)
        }
    }

    private var language: [LanguageParameters] = [] {
        didSet {
            let origin = self.language[0]
            requestLanguageTextButton?(origin.nameLanguage)
            requestTextField?(origin.text)
            let destination = self.language[1]
            resultLanguageTextButton?(destination.nameLanguage)
            resultText?(destination.text)
        }
    }

    // MARK: - Initializer

    init(repository: TranslatorRepositoryType, translationType: TranslationType,
         
         delegate: TranslatorViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
        self.translationType = translationType
    }

    private func initializeLanguage(with parameter: TranslationType) -> [LanguageParameters] {
        return [LanguageParameters(nameLanguage:parameter.initialLanguage.nameLanguage,
                                ISOCode: parameter.initialLanguage.ISOCode,
                                text: parameter.initialLanguage.text),
            LanguageParameters(nameLanguage: parameter.destinationLanguage.nameLanguage,
                               ISOCode:parameter.destinationLanguage.ISOCode,
                               
                               text: parameter.destinationLanguage.text)
        ]
    }

    // MARK: - Outputs
    
    var requestLanguageTextButton: ((String) -> Void)?

    var resultLanguageTextButton: ((String) -> Void)?
    
    var requestTextField: ((String) -> Void)?

    var resultText: ((String) -> Void)?

    var nextScreen: ((NextScreen) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        language = initializeLanguage(with: translationType)
    }
    
    func didSelectLanguageType(for type: LanguageType) {
        delegate?.showLanguageChoices(for: type)
    }

    func didPressClearButton() {
        clear()
    }

    func didPressTranslatButton(for requestText: String) {
        repository.getTranslation(for: requestText,
                                  from: language[0].ISOCode,
                                  to: language[1].ISOCode) {
                                    [weak self] (text, error) in
            if let text = text {
                self?.language[0].text = requestText
                self?.language[1].text = text
            } else if error != nil {
                self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
            }
        }
    }

    // MARK: - Private Functions

    private func clear() {
        requestTranslationText.removeAll()
    }

    private func showTranslation(with requestText: String?, and resultText: String?) {
        guard language.count == 2 else {return}

        if let requestText = requestText {
            language[0].text = requestText
        }
        if let resultText = resultText {
            language[1].text = resultText
        }
        language.swapAt(0, 1)
    }


}
