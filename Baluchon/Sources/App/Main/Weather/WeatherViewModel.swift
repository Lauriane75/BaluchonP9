//
//  WeatherViewModel.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

final class WeatherViewModel {

    // MARK: - Properties

    private let delegate: WeatherViewControllerDelegate?

    private let repository: WeatherRepositoryType

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: WeatherViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

//    var requestWeather: [TimeTemperature] = [] {
//        didSet {
//            let keys: [String] = requestWeather.map { $0.key}.sorted(by: { $0 < $1 })
//            self.visibleWeather?(keys)
//        }
//    }

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultTemperature?("")
        repository.getWeather(callback: { [weak self] weather in
            print(weather)
//            self?.requestWeather(from: weather)
        })
    }

//private func initRequestWeather(from timeWeather: Temperature) {
//    requestWeather = timeWeather.weather.map {
//        TimeTemperature((key: $0.key, value: $0.value) }
//    if let value = requestWeather.first?.value {
//        selectedRequestWeatherValueText?("\(value)")
//        }
//    }

    func didPressShowWeather(text: String, from origin: String, to destination: String) {
        repository.showWeather(temperature: text, callback: { text in
            self.resultTemperature?(text)
        })
    }


    func didPressBackToMenu() {
        delegate?.didPressbackToMenu()
    }

    // MARK: - Outputs

    var resultTemperature: ((String) -> Void)?

    var visibleWeather: (([String]) -> Void)?

    var selectedRequestWeatherValueText: ((String) -> Void)?
}


struct TimeTemperature {
    let key: String
    let value: Double
}
