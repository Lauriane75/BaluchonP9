
//  TranslatorViewVerifying.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol TranslatorViewVerifying {
    func showTranslatorView()
    func translatorViewWaitForExistence()
    func translatorViewExists() -> Bool

    // MARK: - Properties

    var frenchButton: XCUIElement { get }
    var englishButton: XCUIElement { get }
    var arrowTranslateButton: XCUIElement { get }
    var textField: XCUIElement { get }
    var clearButton: XCUIElement { get }
}

extension TranslatorViewVerifying {

    func showTranslatorView() {
     let weatherViewUITests = WeatherViewUITests()
        weatherViewUITests.testGoToTranslatorView()
    }

    func translatorViewWaitForExistence() {
        _ = frenchButton.waitForExistence(timeout: 1)
        _ = englishButton.waitForExistence(timeout: 1)
        _ = arrowTranslateButton.waitForExistence(timeout: 1)
        _ = textField.waitForExistence(timeout: 1)
        _ = clearButton.waitForExistence(timeout: 1)
    }

    func translatorViewExists() -> Bool {
        return frenchButton.exists
            && englishButton.exists
            && arrowTranslateButton.exists
            && textField.exists
            && clearButton.exists
    }

    // MARK: - Properties

    var frenchButton: XCUIElement {
        return XCUIApplication().buttons["French"]
    }
    var englishButton: XCUIElement {
        return XCUIApplication().buttons["English"]
    }
    var arrowTranslateButton: XCUIElement {
        return XCUIApplication().children(matching: .window)
            .element(boundBy: 0)
            .children(matching: .other)
            .children(matching: .other)
            .element(boundBy: 0).buttons["arrow translate"]
    }

    var textField: XCUIElement {
        return XCUIApplication().textFields["Entrez votre texte"]
    }
    var clearButton: XCUIElement {
        return XCUIApplication().buttons["X"]
    }

}
