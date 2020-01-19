//
//  LanguagesViewUITests.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

class LanguagesViewUITests: UITestCase, RootViewStarting, LanguageViewVerifying {

    func test_GivenLanguageView_WhenSelectArabicLanguage_ThenArabicLanguageIsSelectedInsideTheButton() {
        // Show View
        showLanguageView()
        XCUIApplication().tabBars.children(matching: .button).element(boundBy: 2).tap()

        // Tap button
        XCTAssertTrue(englishButtonExists())
        englishButton.tap()

        XCTAssertTrue(backButtonExists())

        XCTAssertTrue(navBarTitleExists())

        XCTAssertTrue(arabicSelectButtonExists())
        arabicSelectButton.tap()

        // Check view
        XCTAssertTrue(arabicButtonExists())
    }

    func testtest_GivenLanguageView_WhenBackButtonTap_ThenBackToTranslatorView() {
        showLanguageView()
        XCUIApplication().tabBars.children(matching: .button).element(boundBy: 2).tap()

        // Tap button
        XCTAssertTrue(englishButtonExists())
        englishButton.tap()

        XCTAssertTrue(backButtonExists())
        backButton.tap()

        XCTAssertTrue(englishButtonExists())
    }

}
