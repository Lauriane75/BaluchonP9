//
//  MainViewModelTests.swift
//  BaluchonTests
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

private final class WeatherRemoteMock {
    
    let visibleWeather: [VisibleWeather]
    
    init(weathers: [VisibleWeather]) {
        self.visibleWeather = weathers
    }
    
    func getWeather(completion: ([VisibleWeather]) -> Void) {
        completion(self.visibleWeather)
    }

}

class WeatherViewModel: UIViewController {
    var loadWeather: ((([VisibleWeather]) -> Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather? { weathers in
            // Display weathers
            print(weathers)
        }
    }
}


private final class MockWeatherViewControllerDelegate: WeatherViewControllerDelegate {
    
}

final class WeatherViewModelTests: XCTestCase {
    func testWeather_viewDidLoad() {
        
        let expectedWeathers = [VisibleWeather(cityName: "Paris", temperature: "5.14", iconID: "804", temperatureMax: "6.11", temperatureMin: "3.89"), VisibleWeather(cityName: "Paris", temperature: "5.14", iconID: "804", temperatureMax: "6.11", temperatureMin: "3.89")]
        
        let weatherVM = WeatherViewModel()
        let weatherMock = WeatherRemoteMock(weathers: expectedWeathers)
        weatherVM.loadWeather = weatherMock.getWeather
        
        let exp = expectation(description: "Wait for weather completion")
        
        weatherVM.loadWeather? { receivedWeathers in
            XCTAssertEqual(expectedWeathers, receivedWeathers)
            exp.fulfill()
        }
        
        weatherVM.viewDidLoad()
        wait(for: [exp], timeout: 1.0)
    }
}
    

