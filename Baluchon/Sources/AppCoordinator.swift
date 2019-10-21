//
//  AppCoordinator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class AppCoordinator {

    // MARK: - Properties

    private unowned var appDelegate: AppDelegate

    private let context: Context

    private var mainCoordinator: MainCoordinator?


    // MARK: - Initializer

    init(appDelegate: AppDelegate, context: Context) {
        self.appDelegate = appDelegate
        self.context = context
    }

    // MARK: - Start

    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.makeKeyAndVisible()

//         look & learn
        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }

        showMain()
    }

    // MARK: - Private

    private func showMain() {

        mainCoordinator = MainCoordinator(presenter: appDelegate.window!, context: context)
        mainCoordinator?.start()
    }
}
