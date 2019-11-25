//
//  WeatherRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherRepositoryType: class {
    func getWeather(for city: City, callback: @escaping (Weather) -> Void, error: @escaping (() -> Void))
    
}

final class WeatherRepository: WeatherRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType

    private let token = RequestCancelationToken()

    // MARK: - Initializer

    init(client: HTTPClientType) {
        self.client = client
    }
    
    func getWeather(for city: City, callback: @escaping (Weather) -> Void, error: @escaping (() -> Void)) {
        let stringUrl = "http://api.openweathermap.org/data/2.5/weather?id=\(city.rawValue)&units=metric&appid=916792210f24330ed8b2f3f603669f4d"
        guard let url = URL(string: stringUrl) else { return }

        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { weather in
            callback(weather)
        }
    }
}

enum City: String {
    case paris = "2988507"
    case newYork = "5128581"
    case lyon = "2996944"
    case nantes = "2990969"
    case strasbourg = "2973783"
    case bordeaux = "3031582"
    case toulouse = "2972315"
    case sacramento = "5389489"
    case losAngeles = "5368361"
    case sanDiego = "5391811"
    case chicago = "4887398"
    case houston = "4699066"
    case philadelphia = "4440906"
    case phoenix = "5308655"
}

