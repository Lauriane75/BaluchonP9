//
//  ConverterRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol ConverterRepositoryType: class {
    func getCurrency(callback: @escaping (Currency) -> Void, error: @escaping (() -> Void))
}

final class ConverterRepository: ConverterRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    // MARK: - Initializer

    init(client: HTTPClientType) {
        self.client = client
    }

    // MARK: - Requests

    func getCurrency(callback: @escaping (Currency) -> Void, error: @escaping (() -> Void)) {

        let apiKey = "5f3d531bcfe0d265036a1aa20e889301&format=1&base=EUR&symbols=EUR,USD,GBP,JPY"
        let urlString = "http://data.fixer.io/api/latest?access_key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        client.request(type: Currency.self, requestType: .GET, url: url, cancelledBy: token) { response in

            let item: Currency = Currency(date: response.date, rates: response.rates)

            callback(item)
        }
    }
}
