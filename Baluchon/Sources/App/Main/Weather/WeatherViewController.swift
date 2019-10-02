//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Outlets

    // MARK: - Properties

    var viewModel: WeatherViewModel!

    // MARK: - View life cycle

    weak var delegate: WeatherViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: WeatherViewModel) {
    }
    
    @IBAction func menuButton(_ sender: Any) {
    }


}
