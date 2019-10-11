//
//  WeatherRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherRepositoryType: class {
    func getParisWeather(callback: @escaping (Weather) -> Void)
    func getNewYorkWeather(callback: @escaping (Weather) -> Void)

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

    func getParisWeather(callback: @escaping (Weather) -> Void) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?id=2968815&appid=916792210f24330ed8b2f3f603669f4d"

        let url = URL(string: urlString)!
        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { Parisweather in
            callback(Parisweather)
        }
    }

    func getNewYorkWeather(callback: @escaping (Weather) -> Void) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?id=5128638&appid=916792210f24330ed8b2f3f603669f4d"

        let url = URL(string: urlString)!
        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { NewYorkweather in
            callback(NewYorkweather)
        }
    }

    func showWeather(temperature: String, callback: @escaping (String) -> Void) {
    }

}

