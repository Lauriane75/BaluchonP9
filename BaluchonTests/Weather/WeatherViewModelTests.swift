//
//  MainViewModelTests.swift
//  BaluchonTests
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

private final class MockWeatherRepositoryParis: WeatherRepositoryType {
    func getWeather(for city: City, callback: @escaping (Weather) -> Void) {
    callback(Weather(weather: [WeatherElement(id: 804, main: "Clouds", weatherDescription: "overcast clouds", icon: "04d")], main: Main(temp: 5.14, pressure: 1007, humidity: 100, tempMin: 3.89, tempMax: 6.11), dt: 1573458358, name: "Paris"))
    }

}


final class WeatherViewModelTests: XCTestCase {
    
    func test_GivenWeatherViewModel_WhenViewDidLoad_ThenParisWeatherIsCorrectlyDisplayed() {
        
        let mockRepository = MockWeatherRepositoryParis()
        let viewModel = WeatherViewModel(repository: mockRepository)
               
        let expectation = self.expectation(description: "Paris weather request is correctly returned")
               
        let expectedResult = [
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min"),
            VisibleWeather(cityName: "Paris", temperature: "5°C", iconID: "04d", temperatureMax: "6 °C max", temperatureMin: "3°C min")
        ]

        viewModel.items = { items in
        XCTAssertEqual(items, expectedResult)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
        expectation.fulfill()
            })
        }
        
        viewModel.viewDidLoad()
    
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
