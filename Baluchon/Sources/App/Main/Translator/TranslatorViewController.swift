//
//  TranslatorViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {

    // MARK: - Outlets


    // MARK: - Properties

    var viewModel: TranslatorViewModel!

    weak var delegate: TranslatorViewControllerDelegate?

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: TranslatorViewModel) {
    }

    @IBAction func menuButton(_ sender: Any) {
        viewModel.didPressBackToMenu()
    }
    
}
