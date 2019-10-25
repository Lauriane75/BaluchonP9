//
//  WeatherDataSource.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 10/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class WeatherSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    // MARK: Private properties

    private var items: [VisibleWeather] = []

    // MARK: Public

    func update(with items: [VisibleWeather]) {
        self.items = items
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard items.count > indexPath.item else {
            fatalError() }

        let visibleWeather = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
        cell.configure(with: visibleWeather)
        return cell
    }
}
