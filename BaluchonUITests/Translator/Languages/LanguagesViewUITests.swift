//
//  LanguagesViewUITests.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

class LanguagesViewUITests: UITestCase, RootViewStarting, LanguageViewVerifying {

    func test_GivenLanguageView_WhenBackButtonTap_ThenBackToTranslatorView() {
    // Show view
    showLanguageView()
    // Wait
    languageViewWaitForExistence()
    // Check view
    _ = backButton.waitForExistence(timeout: 1)
    backButton.tap()
    }

}
