//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var initialValuetextField: UITextField!
    @IBOutlet private weak var resultValueLabel: UILabel!
    @IBOutlet private weak var requestPickerView: UIPickerView!
    @IBOutlet private weak var resultPickerView: UIPickerView!
    @IBOutlet private weak var selectedRequestRateValueLabel: UILabel!
    @IBOutlet weak var selectedResultRateValueLabel: UILabel!

    // MARK: - Properties

    var viewModel: ConverterViewModel!

    private var requestDataSource = PickerViewDataSource()
    private var resultDataSource = PickerViewDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        requestPickerView.dataSource = requestDataSource
        requestPickerView.delegate = requestDataSource

        resultPickerView.dataSource = resultDataSource
        resultPickerView.delegate = resultDataSource
        
        bind(to: viewModel)
        bind(to: requestDataSource)
        bind(to: resultDataSource)
        
        viewModel.viewDidLoad()
    }

    private func bind(to dataSource: PickerViewDataSource) {
        dataSource.didSelectItemAt = viewModel.didSelectRequestRate
        dataSource.didSelectItemAt = viewModel.didSelectResultRate
    }

    private func bind(to viewModel: ConverterViewModel) {
        viewModel.visibleRequestRates = { [weak self] rates in
            DispatchQueue.main.async {
                self?.requestDataSource.update(with: rates)
                self?.requestPickerView.reloadAllComponents()
                self?.resultDataSource.update(with: rates)
                self?.resultPickerView.reloadAllComponents()
            }
        }
        viewModel.selectedRequestRateValueText = { [weak self] text in
            DispatchQueue.main.async {
                self?.selectedRequestRateValueLabel.text = text
            }
        }
        viewModel.selectedResultRateValueText = { [weak self] text in
            DispatchQueue.main.async {
                self?.selectedResultRateValueLabel.text = text
            }
        }
    }
    
}
