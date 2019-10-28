//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, CurrencyPickerDelegate {

    // MARK: - Outlets

    @IBOutlet private weak var initialValuetextField: UITextField!
    @IBOutlet private weak var resultValueLabel: UILabel!
    @IBOutlet private weak var requestPickerView: UIPickerView!
    @IBOutlet private weak var resultPickerView: UIPickerView!
    @IBOutlet private weak var selectedRequestRateValueLabel: UILabel!
    @IBOutlet weak var selectedResultRateValueLabel: UILabel!

    // MARK: - Properties

    var viewModel: ConverterViewModel!

    private var requestDataSource = CurrencyPickerDataSource()
    private var resultDataSource = CurrencyPickerDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        requestDataSource.delegate = self
        requestPickerView.dataSource = requestDataSource
        requestPickerView.delegate = requestDataSource

        resultDataSource.delegate = self
        resultPickerView.dataSource = resultDataSource
        resultPickerView.delegate = resultDataSource
        
        bind(to: viewModel)

        viewModel.viewDidLoad()

        cornerRadiusSettings()

//        requestPickerView.selectRow(46, inComponent: 0, animated: true)
//        resultPickerView.selectRow(149, inComponent: 0, animated: true)

    }

    func didSelectItem(for pickerView: UIPickerView, at row: Int) {
        viewModel.didSelectCurrency(at: row, for: pickerView == requestPickerView ? .request : .result)
    }

    // MARK: - Private Functions

    private func bind(to viewModel: ConverterViewModel) {

        viewModel.visibleRates = { [weak self] rates in
            DispatchQueue.main.async {
                self?.requestDataSource.update(with: rates)
                self?.requestPickerView.reloadAllComponents()
                self?.resultDataSource.update(with: rates)
                self?.resultPickerView.reloadAllComponents()
            }
            viewModel.selectedRequestRateValueText = { [weak self] text in
                DispatchQueue.main.async {
                    self?.selectedRequestRateValueLabel.text = text
                }
                viewModel.selectedResultRateValueText = { [weak self] text in
                    DispatchQueue.main.async {
                        self?.selectedResultRateValueLabel.text = text
                    }
                    viewModel.initialValuetextField = { [weak self] text in
                        DispatchQueue.main.async {
                            self?.initialValuetextField.text = text
                        }
                        viewModel.resultText = { [weak self] text in
                            DispatchQueue.main.async {
                                self?.resultValueLabel.text = text
                            }
                        }
                    }
                }
            }
        }
    }

    fileprivate func cornerRadiusSettings() {
//        initialValuetextField.layer.cornerRadius = 40
        resultValueLabel.layer.cornerRadius = 20
        requestPickerView.layer.cornerRadius = 20
        resultPickerView.layer.cornerRadius = 20
        resultValueLabel.layer.cornerRadius = 20

    }

    // MARK: - Test action

    @IBAction func didTapInitialValuetextField(_ sender: Any) {
        guard let textValue = initialValuetextField.text else {
            return
        }
        viewModel.didTapInitialValuetextField(valueFromTextField: Double(textValue)!)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        initialValuetextField.resignFirstResponder()
    }

}
