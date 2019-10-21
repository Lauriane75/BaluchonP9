//
//  MainCoordinator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case weather = 0
    case converter
    case translator
}

protocol TabBarSourceType {
    var items: [UINavigationController] { get set }
}


extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exists")
            }
            return items[item.rawValue]
        }
    }
}

fileprivate class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]

    init() {
        self[.weather].tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        self[.converter].tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        self[.translator].tabBarItem = UITabBarItem(tabBarSystemItem: .contacts,  tag: 2)
    }
}

final class MainCoordinator: NSObject, UITabBarControllerDelegate {

    private let presenter: UIWindow

    private let tabBarController: UITabBarController

    private let screens: Screens

    private var tabBarSource: TabBarSourceType = TabBarSource()

    // MARK: - Init

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter

        self.screens = Screens(context: context)

        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = tabBarSource.items
        tabBarController.selectedViewController = tabBarSource[.weather]

        super.init()

        tabBarController.delegate = self
    }

    func start() {
        presenter.rootViewController = tabBarController
        showMainView()
    }

    private func showMainView() {
        let mainViewController = screens.createMainViewController(delegate: self)
        presenter.rootViewController = mainViewController
    }

    private func showTranslator() {
        let translatorViewController = screens.createTranslatorViewController(delegate: self)
        presenter.rootViewController?.show(translatorViewController, sender: nil)
    }
    
    private func showConverter() {
        let converterViewController = screens.createConverterViewController(delegate: self)
        presenter.rootViewController?.show(converterViewController, sender: nil)
    }
}

extension MainCoordinator: WeatherViewControllerDelegate {

    func didPressTranslatorButton() {
        showTranslator()
    }
    func didPressConverterButton() {
        showConverter()
    }
}

extension MainCoordinator {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < tabBarSource.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Selected ViewController Index Out Of range")
        }

        switch item {
        case .weather:
            showMainView()
        case .converter:
            showConverter()
        case .translator:
            showTranslator()
        }
    }
}


extension MainCoordinator: ConverterViewControllerDelegate {

}

extension MainCoordinator: TranslatorViewControllerDelegate {

}

