//
//  WeatherDataSource.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 10/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class WeatherSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    typealias Item = WeatherViewModel.Item

    // MARK: Private properties

    private var items: [Item] = []

    // MARK: Public

    func update(with items: [Item]) {
        self.items = items
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard items.count > indexPath.item else {
            fatalError()
        }
        switch items[indexPath.item] {
        case .parisWeather(visibleParisWeather: let visibleWeather):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
            cell.configure(with: visibleWeather)
            return cell
        case .newYorkWeather(visibleNewYorkWeather: let visibleWeather):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as!
                CityWeatherTableViewCell
            cell.configure(with: visibleWeather)
            return cell

        }
    }
}
