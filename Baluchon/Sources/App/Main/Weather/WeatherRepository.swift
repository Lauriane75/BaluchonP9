//
//  WeatherRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherRepositoryType: class {
    func getWeather(callback: @escaping (Currency) -> Void)
    func showWeather(temperature: String, callback: @escaping (String) -> Void)
}

final class WeatherRepository: WeatherRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    // MARK: - Initializer

    init(client: HTTPClientType) {
        self.client = client
    }

    func getWeather(callback: @escaping (Currency) -> Void) {
        let urlString = ""
        let url = URL(string: urlString)!
        client.request(type: Currency.self, requestType: .GET, url: url, cancelledBy: token) { currency in
            callback(currency)
        }
    }

    func showWeather(temperature: String, callback: @escaping (String) -> Void) {
    }

}

