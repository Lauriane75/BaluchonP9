//
//  RootViewStarting.swift
//  BaluchonUITests
//
//  Created by Lauriane Haydari on 25/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
protocol RootViewStarting: StartupConfigurable, AppStarting {

    func startRootView()
}

extension RootViewStarting {

    func startRootView() {
        // Use AppStarting to start the app
        startApp()
    }

    func configureStartup() {
        startRootView()
    }

}
