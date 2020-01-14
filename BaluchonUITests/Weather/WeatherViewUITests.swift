//
//  WeatherViewUITests.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

class WeatherViewUITests: UITestCase, RootViewStarting, WeatherViewVerifying {
    

//    func testVerifyingWeatherView() {
//        // Wait
//        weatherViewWaitForExistence()
//        // Check View
//        XCTAssertTrue(weatherViewExists())
//    }
    
    func testVerifyingTabBarItems() {
        // Wait
        tabBaritemsWaitForExistence()
        // Check View
        XCTAssertTrue(tabBaritemsViewExists())
    }
    
    func testGoToConverterView() {
        _ = itemTwo.waitForExistence(timeout: 1)
        itemTwo.tap()
    }
    
    func testGoToTranslatorView() {
        _ = itemTwo.waitForExistence(timeout: 1)
        itemThree.tap()
    }

}
