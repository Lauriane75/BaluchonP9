//
//  TranslatorRepository.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//


import Foundation

protocol TranslatorRepositoryType: class {
    func getTranslation(callback: @escaping (EnglishLanguage) -> Void)
    func translate(text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping (String) -> Void)
}

final class TranslatorRepository: TranslatorRepositoryType {


    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    // MARK: - Initializer

    init(client: HTTPClientType) {
        self.client = client
    }

    // find api url
    func getTranslation(callback: @escaping (EnglishLanguage) -> Void) {
        let urlString = "http://data.fixer.io/api/latest?access_key=5f3d531bcfe0d265036a1aa20e889301&format=1"
        let url = URL(string: urlString)!
        client.request(type: EnglishLanguage.self, requestType: .GET, url: url, cancelledBy: token) { currency in
            callback(currency)
        }
    }

    func translate(text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping (String) -> Void) {
    }

}

