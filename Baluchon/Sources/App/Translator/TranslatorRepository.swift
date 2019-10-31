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

//    func translate(text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping (String) -> Void)
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

//    // find api url
//    func getTranslation(callback: @escaping (Translator) -> Void) {
//        let apiKey = "AIzaSyAsAeyNFUwWfB9jBeT0U6ZkZl6w7G9lkb4"
//        let urlString = "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)&source=fr&target=en&q=bonjour&format=text"
//        let url = URL(string: urlString)!
//        client.request(type: Translator.self, requestType: .GET, url: url, cancelledBy: token) { currency in
//            callback(currency)
//        }
//    }

    func getTranslation(for text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping ((String?, Error?) -> Void)) {

    }

//    func translate(text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping (String) -> Void) {
//
//    }

}

