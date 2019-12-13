//
//  MainViewModelTests.swift
//  BaluchonTests
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

private final class MockWeatherViewControllerDelegate: WeatherViewControllerDelegate {

}

final class MockWeatherRepository: WeatherRepositoryType {
    
    var isSuccess = true
    var weather: Weather!
    
    func getWeather(for city: City, callback: @escaping (Weather) -> Void, error: @escaping (() -> Void)) {
        if isSuccess {
            callback(weather)
        } else {
            error()
        }
    }
}

//final class MockWeatherRepository: WeatherRepositoryType {
//
//    var isSuccess = true
//    var weather: Weather!
//
//    func getWeather(for city: City, callback: @escaping (Weather) -> Void, error: @escaping (() -> Void)) {
//        if isSuccess {
//            callback(weather)
////            callback(Weather(weather: [WeatherElement(icon: "804")], main: Main(temp: 5.14, tempMin: 3.89, tempMax: 6.11), name: "Paris"))
//        } else {
//            error()
//        }
//    }
//}



final class WeatherViewModelTests: XCTestCase {
    
    func testWeather_viewDidLoad() {
        
//        let expectedResult: [WeatherViewModel.Item] = [.weatherElements(weather: VisibleWeather(cityName: "Paris", temperature: "5.14", iconID: "804", temperatureMax: "6.11", temperatureMin: "3.89"))]
        
        let mockRepository = MockWeatherRepository()
        let viewModel = WeatherViewModel(repository: mockRepository, delegate: nil)
        let expectation1 = expectation(description: "Wait for weather completion")
            
        viewModel.items = { items in
            
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

//final class WeatherViewModelTests: XCTestCase {
//
//    func testWeather_viewDidLoad() {
//
////        let expectedResult: [WeatherViewModel.Item] = [.weatherElements(weather: VisibleWeather(cityName: "Paris", temperature: "5.14", iconID: "804", temperatureMax: "6.11", temperatureMin: "3.89"))]
//
//        let mockWeatherRepository = MockWeatherRepository()
//        let viewModel = WeatherViewModel(repository: mockWeatherRepository, delegate: nil)
////        let expectation1 = expectation(description: "Wait for weather completion")
//
////        var counter = 0
//
//        viewModel.items = { items in
//
////            if counter == 1 {
////                XCTAssertEqual(items, expectedResult)
////                expectation1.fulfill()
////            }
////            counter += 1
//        }
//
//        viewModel.viewDidLoad()
//
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//}


