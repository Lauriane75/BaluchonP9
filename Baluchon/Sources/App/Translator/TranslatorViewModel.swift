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

final class TranslatorViewModel {

    // MARK: - Properties

    private let delegate: TranslatorViewControllerDelegate?

    private let repository: TranslatorRepositoryType

    // MARK: Private properties

    private var requestTranslationText = "" {
        didSet {
            requestText?(requestTranslationText)
        }
    }

    // MARK: - Initializer

    init(repository: TranslatorRepositoryType, delegate: TranslatorViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }


    // MARK: - Outputs

    var requestText: ((String) -> Void)?

    var resultText: ((String) -> Void)?

    var nextScreen: ((NextScreen) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultText?("")
//        repository.getTranslation(callback: { [weak self] english in
//            print(english)
//        })
    }

    func didPressResultArrowButton() {
//        translate(text: <#T##String#>, from: <#T##String#>, to: <#T##String#>)
    }


    func didTapRequestTextField(text : String?) {
        print(text!)
    }

    func didPressClearButton() {
        clear()

    }

    func didPressResultTranslationButton() {

    }

    // MARK: - Private Functions

    private func clear() {
        requestTranslationText.removeAll()
    }

    private func translate(text: String, from origin: String, to destination: String) {
        repository.translate(text: text, from: origin, to: destination, callback: { text in
            self.resultText?(text)
        })
    }

}

