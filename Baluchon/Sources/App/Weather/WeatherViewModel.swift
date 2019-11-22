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
    
    var weatherItems: [WeatherItem] = [] {
           didSet {
            let items = weatherItems.map { Item(weatherItem: $0) }
               self.items?(items)
           }
       }
    
    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: WeatherViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var items: (([Item]) -> Void)?
    
    var nextScreen: ((NextScreen) -> Void)?
    
    enum Item: Equatable {
        case weatherElements(weather: VisibleWeather)
     }
    
    enum WeatherItem {
        case weatherType(weather: Weather)
    }

    // MARK: - Inputs
    
    func viewDidLoad() {
        repository.getWeather(for: .paris, callback: { (parisWeather) in
            self.repository.getWeather(for: .newYork, callback: { (newYorkWeather) in
            self.repository.getWeather(for: .nantes, callback: { (nantesWeather) in
            self.repository.getWeather(for: .bordeaux, callback: { (bordeauxWeather) in
            self.repository.getWeather(for: .lyon, callback: { (lyonWeather) in
            self.repository.getWeather(for: .losAngeles, callback: { (losAngelesWeather) in
            self.repository.getWeather(for: .chicago, callback: { (chicagoWeather) in
            self.repository.getWeather(for: .houston, callback: { (houstonWeather) in

                
        DispatchQueue.main.async {
            self.weatherItems = WeatherViewModel.self.initialize(parisWeather, newYorkWeather, nantesWeather, bordeauxWeather, lyonWeather, losAngelesWeather, chicagoWeather, houstonWeather)
            }
        }, error: { [weak self] in
                self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
                
        }, error: { [weak self] in
            self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
        }, error: { [weak self] in
        self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
        }, error: { [weak self] in
        self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
        }, error: { [weak self] in
        self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
        }, error: { [weak self] in
        self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
        }, error: { [weak self] in
        self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
        }, error: { [weak self] in
        self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
        })
    }

    
    // MARK: - Private Files
        
        
    private static func initialize(_ weather1: Weather, _ weather2: Weather, _ weather3: Weather, _ weather4: Weather, _ weather5: Weather, _ weather6: Weather, _ weather7: Weather, _ weather8: Weather) -> [WeatherItem] {
        var weatherItems: [WeatherItem] = []
        weatherItems.append(.weatherType(weather: weather1))
        weatherItems.append(.weatherType(weather: weather2))
        weatherItems.append(.weatherType(weather: weather3))
        weatherItems.append(.weatherType(weather: weather4))
        weatherItems.append(.weatherType(weather: weather5))
        weatherItems.append(.weatherType(weather: weather6))
        weatherItems.append(.weatherType(weather: weather7))
        weatherItems.append(.weatherType(weather: weather8))
        return weatherItems
    }
}

extension WeatherViewModel.Item {
    init(weatherItem: WeatherViewModel.WeatherItem) {
        
        switch weatherItem {
        case .weatherType(weather: let weather):
            
        var imageName = ""
            
        for (_, index) in weather.weather.enumerated() {
        imageName =  "\(index.icon)"
        }
            
        self = .weatherElements(weather: VisibleWeather(cityName: "\(weather.name)", temperature: "\(weather.main.temp)", iconID: "\(imageName)", temperatureMax: "\(weather.main.tempMax)", temperatureMin: "\(weather.main.tempMin)"))
            
        }
    }
}
