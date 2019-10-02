//
//  MainViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var translatorButton: UIButton!
    @IBOutlet private weak var weatherButton: UIButton!
    @IBOutlet private weak var converterButton: UIButton!

    // MARK: - Properties

    var viewModel: MainViewModel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: MainViewModel) {
        viewModel.translatorText = { [weak self] text in
            self?.translatorButton.setTitle(text, for: .normal)
        }

        viewModel.converterText = { [weak self] text in
            self?.converterButton.setTitle(text, for: .normal)
        }

        viewModel.weatherText = { [weak self] text in
            self?.weatherButton.setTitle(text, for: .normal)
        }
    }

    // MARK: - Actions

    @IBAction private func didPressTranslatorButton(_ sender: Any) {
        viewModel.didPressTranslatorButton()
    }

    @IBAction private func didPressWeatherButton(_ sender: Any) {
        viewModel.didPressWeatherButton()
    }

    @IBAction private func didPressConverterButton(_ sender: Any) {
        viewModel.didPressConverterButton()
    }
}
