//
//  CityWeatherTableViewCell.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 08/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class CityWeatherTableViewCell: UITableViewCell {

    // MARK: - Outlets
        
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempOfTheDayLabel: UILabel!

    func configure(with visibleWeather: VisibleWeather) {
        cityLabel.text = visibleWeather.cityName
        iconImageView.image = UIImage(named: String(visibleWeather.iconID))
        tempMinLabel.text = String(visibleWeather.temperatureMin)
        tempMaxLabel.text = String(visibleWeather.temperatureMax)
        tempOfTheDayLabel.text = String(visibleWeather.temperature)
    }
    
}

