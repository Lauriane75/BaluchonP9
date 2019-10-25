//
//  WeatherViewModel.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

struct VisibleWeather {
    let cityName: String
    let temperature: Double
    let iconID: Int
    let temperatureMax: Double
    let temperatureMin: Double
}



final class WeatherViewModel {

    // MARK: - Properties

    private let delegate: WeatherViewControllerDelegate?

    private let repository: WeatherRepositoryType

    private var visibleItems: [VisibleWeather] = [] {
        didSet {
            items?(visibleItems)
        }
    }

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: WeatherViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var items: (([VisibleWeather]) -> Void)?

    var weatherString: ((String) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        let parisUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=2968815&units=metric&appid=916792210f24330ed8b2f3f603669f4d")!

        let newyorkURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=5128638&units=metric&appid=916792210f24330ed8b2f3f603669f4d")!

        let londonURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=2643743&units=metric&appid=916792210f24330ed8b2f3f603669f4d")!

        repository.getWeather(url: parisUrl, callback: { [weak self] parisWeather in
            DispatchQueue.main.async {
                self?.visibleItems.append(WeatherViewModel.initializeItems(with: parisWeather))
            }
        })

        repository.getWeather(url: newyorkURL, callback: { [weak self] newyorkURL in
            DispatchQueue.main.async {
                self?.visibleItems.append(WeatherViewModel.initializeItems(with: newyorkURL))
            }
        })

        repository.getWeather(url: londonURL, callback: { [weak self] londonURL in
            DispatchQueue.main.async {
                self?.visibleItems.append(WeatherViewModel.initializeItems(with: londonURL))
            }
        })

    }

    private static func initializeItems(with weather: Weather) -> VisibleWeather {
        return VisibleWeather(cityName: weather.name,
            temperature: weather.main.temp, iconID: weather.id, temperatureMax: weather.main.tempMax, temperatureMin: weather.main.tempMin)
    }



}



