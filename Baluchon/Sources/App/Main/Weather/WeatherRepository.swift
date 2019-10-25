//
//  WeatherRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherRepositoryType: class {
    func getWeather(url: URL, callback: @escaping (Weather) -> Void)
//    func getNewYorkWeather(callback: @escaping (Weather) -> Void)

}

final class WeatherRepository: WeatherRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    // MARK: - Initializer

    init(client: HTTPClientType) {
        self.client = client

    }

    func getWeather(url: URL, callback: @escaping (Weather) -> Void) {
        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { weather in
            callback(weather)
        }
    }

}

