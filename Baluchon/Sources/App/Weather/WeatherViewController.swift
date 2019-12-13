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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties

    var viewModel: WeatherViewModel!

    weak var delegate: WeatherViewControllerDelegate?

    private var source = WeatherDataSource()

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
        viewModel.activityIndicatorIsLoading = { [weak self] loadingState in
            switch loadingState {
                 case true:
                     self?.tableView.isHidden = true
                     self?.activityIndicator.startAnimating()
                 case false:
                     self?.tableView.isHidden = false
                     self?.activityIndicator.stopAnimating()
            }
        }
    }

}
