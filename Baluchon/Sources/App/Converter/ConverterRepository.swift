//
//  ConverterRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol ConverterRepositoryType: class {
    func getCurrency(callback: @escaping (Currency) -> Void)
    func convert(fromValue: String, from originCurrency: String, to destinateCurrency: String, callback: @escaping (String) -> Void)
}

final class ConverterRepository: ConverterRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    // MARK: - Initializer

    init(client: HTTPClientType) {
        self.client = client
    }

    func getCurrency(callback: @escaping (Currency) -> Void) {

        let apiKey = "5f3d531bcfe0d265036a1aa20e889301&format=1"
        let urlString = "http://data.fixer.io/api/latest?access_key=\(apiKey)"
        let url = URL(string: urlString)!
        client.request(type: Currency.self, requestType: .GET, url: url, cancelledBy: token) { currency in

            callback(currency)
        }
    }

    func convert(fromValue: String, from originCurrency: String, to destinateCurrency: String, callback: @escaping (String) -> Void) {

    }
}
