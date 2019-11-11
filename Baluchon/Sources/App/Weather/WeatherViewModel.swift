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
        getWeatherCells()
    }
    
    // MARK: - Private Files
    
    func getWeatherCells() {
        repository.getWeather(for: .paris, callback: { parisWeather in
            self.visibleItems.append(VisibleWeather(weather: parisWeather))

            self.repository.getWeather(for: .newYork, callback: { newYorkWeather in
            self.visibleItems.append(VisibleWeather(weather: newYorkWeather))
            })
            self.repository.getWeather(for: .lyon, callback: { lyonWeather in
            self.visibleItems.append(VisibleWeather(weather: lyonWeather))
            })
            self.repository.getWeather(for: .nantes, callback: { nantesWeather in
            self.visibleItems.append(VisibleWeather(weather: nantesWeather))
            })
            self.repository.getWeather(for: .strasbourg, callback: { strasbourgWeather in
            self.visibleItems.append(VisibleWeather(weather: strasbourgWeather))
            })
            self.repository.getWeather(for: .bordeaux, callback: { bordeauxWeather in
            self.visibleItems.append(VisibleWeather(weather: bordeauxWeather))
            })
            self.repository.getWeather(for: .toulouse, callback: { toulouseWeather in
            self.visibleItems.append(VisibleWeather(weather: toulouseWeather))
            })
            self.repository.getWeather(for: .sacramento, callback: { sacramentoWeather in
            self.visibleItems.append(VisibleWeather(weather: sacramentoWeather))
            })
            self.repository.getWeather(for: .losAngeles, callback: { losAngelesWeather in
            self.visibleItems.append(VisibleWeather(weather: losAngelesWeather))
            })
            self.repository.getWeather(for: .sanDiego, callback: { sanDiegoWeather in
            self.visibleItems.append(VisibleWeather(weather: sanDiegoWeather))
            })
            self.repository.getWeather(for: .chicago, callback: { chicagoWeather in
            self.visibleItems.append(VisibleWeather(weather: chicagoWeather))
            })
            self.repository.getWeather(for: .houston, callback: { houstonWeather in
            self.visibleItems.append(VisibleWeather(weather: houstonWeather))
            })
            self.repository.getWeather(for: .philadelphia, callback: { philadelphiaWeather in
            self.visibleItems.append(VisibleWeather(weather: philadelphiaWeather))
            })
            self.repository.getWeather(for: .phoenix, callback: { phoenixWeather in
            self.visibleItems.append(VisibleWeather(weather: phoenixWeather))
            })
        })
    }
    

}


extension VisibleWeather {
    init(weather: Weather) {
        var imageName = ""        
        
        for (_, index) in weather.weather.enumerated() {
            imageName =  "\(index.icon)"
            
        }
        self.iconID = "\(imageName)"
        self.cityName = weather.name
        self.temperatureMax = "\(Int(weather.main.tempMax)) °C max"
        self.temperature = "\(Int(weather.main.temp))°C"
        self.temperatureMin = "\(Int(weather.main.tempMin))°C min"
    }
}

