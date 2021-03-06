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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var initialValuetextField: UITextField!
    @IBOutlet private weak var resultValueLabel: UILabel!
    @IBOutlet private weak var requestPickerView: UIPickerView!
    @IBOutlet private weak var resultPickerView: UIPickerView!
    @IBOutlet private weak var selectedRequestRateValueLabel: UILabel!
    @IBOutlet weak var selectedResultRateValueLabel: UILabel!

    // MARK: - Properties

    var viewModel: ConverterViewModel!

    // MARK: - Private properties

    private var requestDataSource = RequestPickerViewDataSource()
    private var resultDataSource = ResultPickerViewDataSource()

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
        elementsCustomCornerRadius()
        initialValuetextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.green ])
    }

    private func bind(to viewModel: ConverterViewModel) {
        viewModel.titleLabel = { [weak self] text in
            self?.titleLabel.text = text
        }
        viewModel.initialValuetextField = { [weak self] text in
                DispatchQueue.main.async {
                self?.initialValuetextField.text = text
            }
        }
        viewModel.placeHolderTextField = { [weak self] text in
                DispatchQueue.main.async {
                self?.initialValuetextField.placeholder = text
            }
        }
        viewModel.visibleRequestCurrencyName = { [weak self] rates in
               DispatchQueue.main.async {
                self?.requestDataSource.update(with: rates)
                self?.requestPickerView.reloadAllComponents()
            }
        }
        viewModel.visibleResultCurrencyName = { [weak self] rates in
                DispatchQueue.main.async {
                self?.resultDataSource.update(with: rates)
                self?.resultPickerView.reloadAllComponents()
            }
        }
        viewModel.selectedRequestRateValue = { [weak self] text in
                DispatchQueue.main.async {
                self?.selectedRequestRateValueLabel.text = text
            }
        }
        viewModel.selectedResultRateValue = { [weak self] text in
                DispatchQueue.main.async {
                self?.selectedResultRateValueLabel.text = text
            }
        }
        viewModel.resultText = { [weak self] text in
                DispatchQueue.main.async {
                self?.resultValueLabel.text = text
            }
        }
        viewModel.nextScreen = { [weak self] screen in
            DispatchQueue.main.async {
            guard let self = self else { return }
            if case .alert(title: let title, message: let message) = screen {
            AlertPresenter().presentAlert(on: self, with: title, message: message)
            }
        }
    }
}

    private func bind(to dataSource: RequestPickerViewDataSource) {
        dataSource.didSelectItemAt = viewModel.didSelectRequestRate
      }

    private func bind(to dataSource: ResultPickerViewDataSource) {
        dataSource.didSelectItemAt = viewModel.didSelectResultRate
      }

    private func elementsCustomCornerRadius() {
        resultValueLabel.layer.cornerRadius = 20
        requestPickerView.layer.cornerRadius = 20
        resultPickerView.layer.cornerRadius = 20
        resultValueLabel.layer.cornerRadius = 20
    }

    // MARK: - Test action

    @IBAction func didTapInitialValuetextField(_ sender: Any) {
        guard initialValuetextField.text != nil else { return }
        guard let textValue = initialValuetextField.text else {
            return
        }
        viewModel.didTapInitialValuetextField(valueFromTextField: Double(textValue)!)
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        initialValuetextField.resignFirstResponder()
    }
}
