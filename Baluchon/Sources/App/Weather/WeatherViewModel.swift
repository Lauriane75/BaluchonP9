//
//  WeatherViewModel.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

struct VisibleWeather: Equatable {
    let cityName: String
    let temperature: String
    let iconID: String
    let temperatureMax: String
    let temperatureMin: String
}

final class WeatherViewModel {

    // MARK: - Properties

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

    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }

    // MARK: - Outputs

    var items: (([VisibleWeather]) -> Void)?

    var nextScreen: ((NextScreen) -> Void)?

    var activityIndicatorIsLoading: ((Bool) -> Void)?

    // MARK: - Private Files

    fileprivate func errorNoService() { self.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
    }

    fileprivate func showWeathers() {
        activityIndicatorIsLoading?(false)
        repository.getWeather(callback: { weather in
            self.visibleItems = weather.list.map { city in
                VisibleWeather(cityName: city.name, temperature: "\(Int(city.main.temp)) °C", iconID: city.weather.first?.icon ?? "01d", temperatureMax: "\(Int(city.main.tempMax)) °C max", temperatureMin: "\(Int(city.main.tempMin)) °C min")
            }
        }, error: { [weak self] in
            self!.errorNoService()
        })
    }

    // MARK: - Inputs
    func viewDidLoad() {
        activityIndicatorIsLoading?(true)
        showWeathers()
    }
}
