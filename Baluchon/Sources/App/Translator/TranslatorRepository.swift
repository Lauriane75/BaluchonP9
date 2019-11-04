//
//  TranslatorRepository.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//


import Foundation
import SwiftGoogleTranslate

protocol TranslatorRepositoryType: class {

func getTranslation(for text: String,
                    from originLanguage: String,
                    to destinationLanguage: String,
                    callback: @escaping ((String?, Error?) -> Void))
}

final class TranslatorRepository: TranslatorRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    private var translator: SwiftGoogleTranslate

    // MARK: - Initializer

    init(client: HTTPClientType) {
        translator = SwiftGoogleTranslate.shared
        translator.start(with: "AIzaSyBP0KxCjiYHKryO2NlZrsb2RYhqzHTlrog")
        self.client = client
    }

    func getTranslation(for text: String,
                        from originLanguage: String,
                        to destinationLanguage: String,
                        callback: @escaping ((String?, Error?) -> Void)) {
        translator.translate(text, destinationLanguage, originLanguage) { (text, error) in
                  callback(text, error)
              }

    }

}

