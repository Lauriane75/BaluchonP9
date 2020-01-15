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
    var newYorkLabel: XCUIElement { get }
    var lyonLabel: XCUIElement { get }
    var nantesLabel: XCUIElement { get }
    var bordeauxLabel: XCUIElement { get }
    var toulouseLabel: XCUIElement { get }
    var losangelesLabel: XCUIElement { get }
    var sandiegoLabel: XCUIElement { get }
    var chicagoLabel: XCUIElement { get }
    var philadelphiaLabel: XCUIElement { get }
    var phoenixLabel: XCUIElement { get }

    var itemOne: XCUIElement { get }
    var itemTwo: XCUIElement { get }
    var itemThree: XCUIElement { get }

}

extension WeatherViewVerifying {

    func weatherViewWaitForExistence() {
        _ = parisLabel.waitForExistence(timeout: 1)
        _ = newYorkLabel.waitForExistence(timeout: 1)
        _ = lyonLabel.waitForExistence(timeout: 1)
        _ = nantesLabel.waitForExistence(timeout: 1)
        _ = bordeauxLabel.waitForExistence(timeout: 1)
        _ = toulouseLabel.waitForExistence(timeout: 1)
        _ = losangelesLabel.waitForExistence(timeout: 1)
        _ = sandiegoLabel.waitForExistence(timeout: 1)
        _ = chicagoLabel.waitForExistence(timeout: 1)
        _ = philadelphiaLabel.waitForExistence(timeout: 1)
        _ = phoenixLabel.waitForExistence(timeout: 1)
    }

    func weatherViewExists() -> Bool {
        return parisLabel.exists &&
            newYorkLabel.exists &&
            lyonLabel.exists &&
            nantesLabel.exists &&
            bordeauxLabel.exists &&
            toulouseLabel.exists &&
            losangelesLabel.exists &&
            sandiegoLabel.exists &&
            chicagoLabel.exists &&
            philadelphiaLabel.exists &&
            phoenixLabel.exists
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
    var newYorkLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["New York"]
    }
    var lyonLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Lyon"]
    }
    var nantesLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Nantes"]
    }
    var bordeauxLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Bordeaux"]
    }
    var toulouseLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Toulouse"]
    }
    var losangelesLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Los Angeles"]
    }
    var sandiegoLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["San Diego"]
    }
    var chicagoLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Chicago"]
    }
    var philadelphiaLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Philadelphia"]
    }
    var phoenixLabel: XCUIElement {
        return XCUIApplication().tables.staticTexts["Phoenix"]
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
