//
//  AppDelegate.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 03/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var context: Context!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let client = HTTPClient()
        context = Context(client: client)
        appCoordinator = AppCoordinator(appDelegate: self, context: context)
        appCoordinator?.start()

        return true
    }
}
