//
//  WeatherRepositoryType.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherRepositoryType: class {
    func getWeather(callback: @escaping (Weather) -> Void, error: @escaping (() -> Void))
}

final class WeatherRepository: WeatherRepositoryType {
    
    // MARK: - Properties
    
    private let client: HTTPClientType
    
    private let token = RequestCancelationToken()
    
    // MARK: - Initializer
    
    init(client: HTTPClientType) {
        self.client = client
    }
    
    func getWeather(callback: @escaping (Weather) -> Void, error: @escaping (() -> Void)) {
        let stringUrl = "http://api.openweathermap.org/data/2.5/group?id=2988507,5128581,2996944,2990969,3031582,2972315,,5368361,5391811,4887398,4440906,5308655&units=metric&appid=916792210f24330ed8b2f3f603669f4d"
        guard let url = URL(string: stringUrl) else { return }
        
        client.request(type: Weather.self, requestType: .GET, url: url, cancelledBy: token) { weather in
            callback(weather)
        }
    }
}


