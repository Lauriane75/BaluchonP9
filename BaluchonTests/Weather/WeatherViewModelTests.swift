//
//  MainViewModelTests.swift
//  BaluchonTests
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

final class MockWeatherRepository: WeatherRepositoryType {

    var isSuccess = true
    var weather: Weather!

    func getWeather(callback: @escaping (Weather) -> Void, error: @escaping (() -> Void)) {
        if isSuccess {
            callback(Weather(cnt: 0,
                             list: [List(weather: [WeatherElement(icon: "01d")],
                                         main: Main(temp: 5.14, tempMin: 3.89, tempMax: 6.11), name: "Paris")]))
        } else {
            error()
        }

    }
}

final class WeatherViewModelTests: XCTestCase {

    func test_Weather_viewDidLoad() {

        let expectedResult = [VisibleWeather(cityName: "Paris", temperature: "5 °C", iconID: "01d", temperatureMax: "6 °C max", temperatureMin: "3 °C min")]
        let mockRepository = MockWeatherRepository()
        let viewModel = WeatherViewModel(repository: mockRepository)
        let expectation1 = expectation(description: "Wait for weather completion")

        viewModel.items = { items in
                XCTAssertEqual(items, expectedResult)
                expectation1.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
