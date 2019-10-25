//
//  TabBarController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 13/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//


import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Properties

    var viewModel: WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()


        let weatherViewController = WeatherViewController()
        let converterViewController = ConverterViewController()
        let translatorViewController = TranslatorViewController()

        weatherViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        converterViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        translatorViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let tabBarList = [weatherViewController, converterViewController, translatorViewController]

        viewControllers = tabBarList

    }

    private func bind(to viewModel: WeatherViewModel) {

    }

        // MARK: - Action




}
