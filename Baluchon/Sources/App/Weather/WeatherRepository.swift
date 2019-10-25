//
//  WeatherRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherRepositoryType: class {
    func getWeather(for city: City, callback: @escaping (Weather) -> Void)
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

    func getWeather(for city: City, callback: @escaping (Weather) -> Void) {
        let stringUrl = "http://api.openweathermap.org/data/2.5/weather?id=\(city.rawValue)&units=metric&appid=916792210f24330ed8b2f3f603669f4d"
        guard let url = URL(string: stringUrl) else { return }

        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { weather in
            callback(weather)
        }
    }

//    func getWeather(for city: City, callback: @escaping (Weather) -> Void) {
//        let stringUrl = "http://api.openweathermap.org/data/2.5/forecast?id=\(city)&appid=916792210f24330ed8b2f3f603669f4d"
//        guard let url = URL(string: stringUrl) else { return }
//
//        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { weather in
//            callback(weather)
//        }
//    }


}

enum City: String {
    case paris = "2968815"
    case newYork = "5128638"
}

/*
 Id New York : 5128638

 http://api.openweathermap.org/data/2.5/forecast?id=5128638&appid=916792210f24330ed8b2f3f603669f4d

 Id Paris : 2968815

 http://api.openweathermap.org/data/2.5/forecast?id=2968815&appid=916792210f24330ed8b2f3f603669f4d


 */
