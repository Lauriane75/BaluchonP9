//
//  WeatherViewVerifying.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol WeatherViewVerifying {
    func weatherViewWaitForExistence()
    func weatherViewExists() -> Bool
    func tabBaritemsWaitForExistence()
    func tabBaritemsViewExists() -> Bool
    
    // MARK: - Properties

    var parisLabel: XCUIElement { get }
    var nantesLabel: XCUIElement { get }
    var lyonLabel: XCUIElement { get }
    var losangelesLabel: XCUIElement { get }
    var chicagoLabel: XCUIElement { get }
    var houstonLabel: XCUIElement { get }
    
    var itemOne: XCUIElement { get }
    var itemTwo: XCUIElement { get }
    var itemThree: XCUIElement { get }
    
}

extension WeatherViewVerifying {
    
    func weatherViewWaitForExistence() {
        _ = parisLabel.waitForExistence(timeout: 1)
        _ = nantesLabel.waitForExistence(timeout: 1)
        _ = lyonLabel.waitForExistence(timeout: 1)
        _ = losangelesLabel.waitForExistence(timeout: 1)
        _ = chicagoLabel.waitForExistence(timeout: 1)
        _ = houstonLabel.waitForExistence(timeout: 1)
    }
    
    func weatherViewExists() -> Bool {
        return parisLabel.exists && nantesLabel.exists && lyonLabel.exists && losangelesLabel.exists && chicagoLabel.exists && houstonLabel.exists
    }
    
    func tabBaritemsWaitForExistence() {
          _ = itemOne.waitForExistence(timeout: 1)
          _ = itemTwo.waitForExistence(timeout: 1)
          _ = itemThree.waitForExistence(timeout: 1)
      }
      
      func tabBaritemsViewExists() -> Bool {
          return itemOne.exists && itemOne.exists && itemThree.exists
      }

    // MARK: - Properties
    
    var parisLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Paris"]
    }
    var nantesLabel: XCUIElement {
           return XCUIApplication().tables.staticTexts["Nantes"]
    }
    var lyonLabel: XCUIElement {
          return XCUIApplication().tables.staticTexts["Lyon"]
    }
    var losangelesLabel: XCUIElement {
           return XCUIApplication().tables.staticTexts["Los Angeles"]
    }
    var chicagoLabel: XCUIElement {
           return XCUIApplication().tables.staticTexts["Chicago"]
    }
    var houstonLabel: XCUIElement {
           return XCUIApplication().tables.staticTexts["Houston"]
    }
    
    var itemOne: XCUIElement {
        return XCUIApplication().tabBars.children(matching: .button).element(boundBy: 0)
    }
    var itemTwo: XCUIElement {
        return XCUIApplication().tabBars.children(matching: .button).element(boundBy: 1)
    }
    var itemThree: XCUIElement {
        return XCUIApplication().tabBars.children(matching: .button).element(boundBy: 2)
    }
    
}

