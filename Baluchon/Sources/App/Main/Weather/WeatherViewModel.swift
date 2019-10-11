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

    private var visibleItems: [Item] = [] {
        didSet {
            items?(visibleItems)
        }
    }

    enum Item {
        case parisWeather(visibleParisWeather: VisibleWeather)
        case newYorkWeather(visibleNewYorkWeather: VisibleWeather)
    }

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: WeatherViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var items: (([Item]) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        repository.getParisWeather(callback: { [weak self] parisWeather in

            DispatchQueue.main.async {
                self?.visibleItems = WeatherViewModel.initializeItems(with: parisWeather)
            }
        })

        repository.getNewYorkWeather(callback: { [weak self] newYorkWeather in

            DispatchQueue.main.async {
                self?.visibleItems = WeatherViewModel.initializeItems(with: newYorkWeather)
            }
        })

    }

    private static func initializeItems(with weather: Weather) -> [Item] {
        let visibleWeather = VisibleWeather(cityName: weather.name,
                                            temperature: weather.main.temp,
                                            iconID: weather.id,
                                            temperatureMax: weather.main.tempMax,
                                            temperatureMin: weather.main.tempMin)


        let item1 = Item.parisWeather(visibleParisWeather: visibleWeather)
        let item2 = Item.newYorkWeather(visibleNewYorkWeather: visibleWeather)


        return [item1, item2]
    }

    func didPressShowWeather(text: String, from origin: String, to destination: String) {
        repository.showWeather(temperature: text, callback: { text in

        })
    }

    func didPressBackToMenu() {
        delegate?.didPressbackToMenu()
    }
}

