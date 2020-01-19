//
//  LanguageViewVerifying.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol LanguageViewVerifying {
    func showLanguageView()

    func englishButtonExists() -> Bool

    func arabicButtonExists() -> Bool

    func arabicSelectButtonExists() -> Bool

    func navBarTitleExists() -> Bool

    func backButtonExists() -> Bool

    // MARK: - Properties

    var backButton: XCUIElement { get }

    var englishButton: XCUIElement { get }

    var arabicSelectButton: XCUIElement { get }
}


extension LanguageViewVerifying {

    func showLanguageView() {
        let translatorViewUITests = TranslatorViewUITests()
        translatorViewUITests.testGoToLanguageView()
    }

    func englishButtonExists() -> Bool {
        _ = englishButton.waitForExistence(timeout: 1)
    return englishButton.exists
    }

    func arabicButtonExists() -> Bool {
        _ = arabicButton.waitForExistence(timeout: 1)
        return arabicButton.exists
    }

    func arabicSelectButtonExists() -> Bool {
        _ = arabicSelectButton.waitForExistence(timeout: 1)
    return arabicSelectButton.exists
    }

    func navBarTitleExists() -> Bool {
        _ = navBar.waitForExistence(timeout: 1)
    return navBar.exists
    }

    func backButtonExists() -> Bool {
        _ = backButton.waitForExistence(timeout: 1)
       return backButton.exists
    }


    // MARK: - Properties

    var backButton: XCUIElement {
        return XCUIApplication().navigationBars["Select a language"].buttons["Back"]
    }

    var englishButton: XCUIElement {
        return XCUIApplication().buttons["English"]
    }

    var arabicButton: XCUIElement {
        return XCUIApplication().buttons["Arabic"]
    }

    var arabicSelectButton: XCUIElement {
        return XCUIApplication().tables.staticTexts["Arabic"]
    }

    var navBar: XCUIElement {
        return XCUIApplication().navigationBars["Select a language"].staticTexts["Select a language"]
    }

}
