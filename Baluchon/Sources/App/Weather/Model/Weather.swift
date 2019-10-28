//
//  Weather.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 25/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation


// MARK: - Weather
struct Weather: Codable {
    let weather: [WeatherElement]
    let main: Main
    let dt: Int
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

