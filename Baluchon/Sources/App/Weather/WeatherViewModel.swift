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
    let temperature: String
    let iconID: String
    let temperatureMax: String
    let temperatureMin: String
}

final class WeatherViewModel {

    // MARK: - Properties

    private let delegate: WeatherViewControllerDelegate?

    private let repository: WeatherRepositoryType

    private var visibleItems: [VisibleWeather] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.items?(self.visibleItems)
            }
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
        repository.getWeather(for: .paris, callback: { parisWeather in
            self.repository.getWeather(for: .newYork, callback: { newYorkWeather in
                self.repository.getWeather(for: .paris, callback: { desnouillesWeather in
                    self.visibleItems.append(VisibleWeather(weather: parisWeather))
                    self.visibleItems.append(VisibleWeather(weather: newYorkWeather))
                     self.visibleItems.append(VisibleWeather(weather: desnouillesWeather))
                })
            })
        })
    }
}

extension VisibleWeather {
    init(weather: Weather) {
        self.cityName = weather.name
        self.temperatureMax = "\(Int(weather.main.tempMax)) °C max"
        self.temperature = "\(Int(weather.main.temp))°C"
        self.temperatureMin = "\(Int(weather.main.tempMin))°C min"
        self.iconID = "\(weather.id)"
    }
}

