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

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultTemperature?("")
        //        repository.getWeather(callback: { [weak self] currency in
        //            print(weather)
        //        })
    }

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
}
