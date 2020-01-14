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

    var amountLabel: XCUIElement { get }
    var placeholderTextField: XCUIElement { get }
    var resultLabel: XCUIElement { get }
    }

    extension ConverterViewVerifying {
        
    func showConverterView() {
    let weatherViewUITests = WeatherViewUITests()
    weatherViewUITests.testGoToConverterView()
    }
        
    func converterViewWaitForExistence() {
    _ = amountLabel.waitForExistence(timeout: 1)
    _ = placeholderTextField.waitForExistence(timeout: 1)
    _ = resultLabel.waitForExistence(timeout: 1)
    }
        
    func converterViewExists() -> Bool {
    return amountLabel.exists && placeholderTextField.exists && resultLabel.exists
    }
        
    // MARK: - Properties
           
    var amountLabel: XCUIElement {
        return XCUIApplication().staticTexts["Montant"]
    }
    var placeholderTextField: XCUIElement {
        return XCUIApplication().textFields["Entrez une valeur à convertir et swipez votre devise"]
    }
    var resultLabel: XCUIElement {
        return XCUIApplication().staticTexts["0.0 €"]
    }
}
