//
//  TranslatorViewModel.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

final class TranslatorViewModel {

    // MARK: - Properties

    private let repository: TranslatorRepositoryType

    // MARK: - Initializer

    init(repository: TranslatorRepositoryType) {
        self.repository = repository
    }

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultText?("")
        repository.getTranslation(callback: { [weak self] english in
            print(english)
        })
    }

    func didPressTranslate(text: String, from origin: String, to destination: String) {
        repository.translate(text: text, from: origin, to: destination, callback: { text in
            self.resultText?(text)
        })
    }

    func didPressBackToMenu() {
    
    }


    // MARK: - Outputs

    var resultText: ((String) -> Void)?
}

