//
//  TranslatorViewModel.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

enum NextScreen: Equatable {
    case alert(title: String, message: String)
}

struct TranslationType {
    var originLanguage: (nameLanguage: String, ISOCode: String, text: String)
    var destinationLanguage: (nameLanguage: String, ISOCode: String, text: String)
}

final class TranslatorViewModel {

    // MARK: - Properties

//    private let delegate: TranslatorViewControllerDelegate?

    private let repository: TranslatorRepositoryType

    private let translationType: TranslationType

    typealias LanguageParameters = (nameLanguage: String, ISOCode: String, text: String)

    // MARK: Private properties

    private var requestTranslationText = "" {
        didSet {
            requestText?(requestTranslationText)
        }
    }

    private var language: [LanguageParameters] = [] {
        didSet {
            let origin = self.language[0]
            requestLanguageTextButton?(origin.nameLanguage)
            requestText?(origin.text)
            let destination = self.language[1]
            resultLanguageTextButton?(destination.nameLanguage)
            resultText?(destination.text)
        }
    }

    // MARK: - Initializer

    init(repository: TranslatorRepositoryType, translationType: TranslationType) {
        self.repository = repository
//        self.delegate = delegate
        self.translationType = translationType
    }

    private func initializeLanguage(with parameter: TranslationType) -> [LanguageParameters] {
        return [LanguageParameters(nameLanguage: parameter.originLanguage.nameLanguage, ISOCode: parameter.originLanguage.ISOCode, text: parameter.originLanguage.text),
                LanguageParameters(nameLanguage: parameter.destinationLanguage.nameLanguage, ISOCode: parameter.destinationLanguage.ISOCode, text: parameter.destinationLanguage.text)
        ]
    }

    // MARK: - Outputs

    var requestText: ((String) -> Void)?

    var resultText: ((String) -> Void)?

    var requestLanguageTextButton: ((String) -> Void)?

    var resultLanguageTextButton: ((String) -> Void)?

    var resultTranslationText: ((String) -> Void)?

    var nextScreen: ((NextScreen) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        language = initializeLanguage(with: translationType)
    }

    func didTapRequestTextField(text : String?) {
        print("Origin text = \(text!)")
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
                print("destination text = \(text)")
            } else if error != nil {
                self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
            }
        }
    }

    // MARK: - Private Functions

    private func clear() {
        requestTranslationText.removeAll()
    }


    func showTranslation(with requestText: String?, and resultText: String?) {
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
