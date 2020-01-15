//
//  Weather.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 25/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

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
    let cnt: Int
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let weather: [WeatherElement]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    var icon: String

    enum CodingKeys: String, CodingKey {
        case icon
    }
}
