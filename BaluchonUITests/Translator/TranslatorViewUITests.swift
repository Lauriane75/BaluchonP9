//
//  TranslatorViewUITests.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

class TranslatorViewUITests: UITestCase, RootViewStarting, TranslatorViewVerifying {

//    func testVerifyingTranslatorView() {
//        // Show view
//        showTranslatorView()
//        // Wait
//        translatorViewWaitForExistence()
//        // Check view
//        XCTAssertTrue(translatorViewExists())
//    }
    
    func testGoToLanguageView() {
        // Show view
        showTranslatorView()
        // Go to Language view
        _ = englishButton.waitForExistence(timeout: 1)
        englishButton.tap()
    }

}
