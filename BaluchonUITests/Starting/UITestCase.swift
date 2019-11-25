//
//  UITestCase.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

class UITestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        // If the test is StartupConfigurable test, then call configureStartup()
        (self as? StartupConfigurable)?.configureStartup()
    }
}
