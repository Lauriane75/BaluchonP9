//
//  AppStarting.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol AppStarting {
    func startApp()
}

extension AppStarting {
    func startApp() {
        XCUIApplication().launch()
    }
}
