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
    func languageViewWaitForExistence()
    func languageViewExists() -> Bool

    // MARK: - Properties

    var backButton: XCUIElement { get }

    var englishButton: XCUIElement { get }

    var afrikaansSelectButton: XCUIElement { get }
    var albanianSelectButton: XCUIElement { get }
    var amharicSelectButton: XCUIElement { get }
    var arabicSelectButton: XCUIElement { get }
    var armenianSelectButton: XCUIElement { get }
    var azerbaijaniSelectButton: XCUIElement { get }
    var basqueSelectButton: XCUIElement { get }
    var belarusianSelectButton: XCUIElement { get }
    var bengaliSelectButton: XCUIElement { get }
    var bosnianSelectButton: XCUIElement { get }
    var bulgarianSelectButton: XCUIElement { get }
    var catalanSelectButton: XCUIElement { get }
    var cebuanoSelectButton: XCUIElement { get }
    var chichewaSelectButton: XCUIElement { get }
}

extension LanguageViewVerifying {

    func showLanguageView() {
        let translatorViewUITests = TranslatorViewUITests()
        translatorViewUITests.testGoToLanguageView()
    }

    func languageViewWaitForExistence() {
        _ = afrikaansSelectButton.waitForExistence(timeout: 1)
        _ = albanianSelectButton.waitForExistence(timeout: 1)
        _ = amharicSelectButton.waitForExistence(timeout: 1)
        _ = arabicSelectButton.waitForExistence(timeout: 1)
        _ = armenianSelectButton.waitForExistence(timeout: 1)
        _ = azerbaijaniSelectButton.waitForExistence(timeout: 1)
        _ = basqueSelectButton.waitForExistence(timeout: 1)
        _ = belarusianSelectButton.waitForExistence(timeout: 1)
        _ = bengaliSelectButton.waitForExistence(timeout: 1)
        _ = bosnianSelectButton.waitForExistence(timeout: 1)
        _ = bulgarianSelectButton.waitForExistence(timeout: 1)
        _ = catalanSelectButton.waitForExistence(timeout: 1)
        _ = cebuanoSelectButton.waitForExistence(timeout: 1)
        _ = chichewaSelectButton.waitForExistence(timeout: 1)
    }
    func languageViewExists() -> Bool {
    return afrikaansSelectButton.exists &&
            albanianSelectButton.exists &&
            amharicSelectButton.exists &&
            arabicSelectButton.exists &&
            armenianSelectButton.exists &&
            azerbaijaniSelectButton.exists &&
            basqueSelectButton.exists &&
            belarusianSelectButton.exists &&
            bengaliSelectButton.exists &&
            bosnianSelectButton.exists &&
            bulgarianSelectButton.exists &&
            catalanSelectButton.exists &&
            cebuanoSelectButton.exists &&
            chichewaSelectButton.exists
    }

    // MARK: - Properties

    var backButton: XCUIElement {
        return XCUIApplication().navigationBars["Baluchon.SelectLanguagesView"].buttons["Back"]
    }
    var englishButton: XCUIElement {
        return XCUIApplication().buttons["English"]
    }
    var afrikaansSelectButton: XCUIElement {
        return XCUIApplication().buttons["Afrikaans"]
    }
    var albanianSelectButton: XCUIElement {
        return XCUIApplication().buttons["Albanian"]
    }
    var amharicSelectButton: XCUIElement {
        return XCUIApplication().buttons["Amharic"]
    }
    var arabicSelectButton: XCUIElement {
        return XCUIApplication().buttons["Arabic"]
    }
    var armenianSelectButton: XCUIElement {
        return XCUIApplication().buttons["Armenian"]
    }
    var azerbaijaniSelectButton: XCUIElement {
        return XCUIApplication().buttons["Azerbaijani"]
    }
    var basqueSelectButton: XCUIElement {
        return XCUIApplication().buttons["Basque"]
    }
    var belarusianSelectButton: XCUIElement {
        return XCUIApplication().buttons["Belarusian"]
    }
    var bengaliSelectButton: XCUIElement {
        return XCUIApplication().buttons["Bengali"]
    }
    var bosnianSelectButton: XCUIElement {
        return XCUIApplication().buttons["Bosnian"]
    }
    var bulgarianSelectButton: XCUIElement {
        return XCUIApplication().buttons["Bulgarian"]
    }
    var catalanSelectButton: XCUIElement {
        return XCUIApplication().buttons["Catalan"]
    }
    var cebuanoSelectButton: XCUIElement {
        return XCUIApplication().buttons["Cebuano"]
    }
    var chichewaSelectButton: XCUIElement {
        return XCUIApplication().buttons["Chichewa"]
    }
}
