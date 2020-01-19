//
//  ConverterViewVerifying.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol ConverterViewVerifying {
    func showConverterView()
    func converterViewWaitForExistence()
    func converterViewExists() -> Bool

    // MARK: - Properties

    var titleLabel: XCUIElement { get }
    var placeholderTextField: XCUIElement { get }
    var resultLabel: XCUIElement { get }
    }

    extension ConverterViewVerifying {
    func showConverterView() {
    let weatherViewUITests = WeatherViewUITests()
    weatherViewUITests.testGoToConverterView()
    }

    func converterViewWaitForExistence() {
    _ = titleLabel.waitForExistence(timeout: 1)
    _ = placeholderTextField.waitForExistence(timeout: 1)
    _ = resultLabel.waitForExistence(timeout: 1)
    }

    func converterViewExists() -> Bool {
    return titleLabel.exists && placeholderTextField.exists && resultLabel.exists
    }

    // MARK: - Properties

    var titleLabel: XCUIElement {
           return XCUIApplication().staticTexts["Entrez une valeur à convertir et swipez votre devise"]
    }

    var placeholderTextField: XCUIElement {
        return XCUIApplication().textFields["Exemple : 100"]
    }

    var resultLabel: XCUIElement {
        return XCUIApplication().staticTexts["0.0 €"]
    }
}
