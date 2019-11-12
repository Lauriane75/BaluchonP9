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

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var viewModel: WeatherViewModel!

    weak var delegate: WeatherViewControllerDelegate?

    private var source = WeatherSource()

    // MARK: - View life cycle

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.delegate = source
        tableView.dataSource = source

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: WeatherViewModel) {
        viewModel.items = { [weak self] items in
            self?.source.update(with: items)
            self?.tableView.reloadData()
        }
    }

}
