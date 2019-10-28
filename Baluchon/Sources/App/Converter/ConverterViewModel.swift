//
//  ConverterViewModel.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

enum ConverterType {
    case result
    case request
}

struct Rate {
    let key: String
    let value: Double
}

final class ConverterViewModel {

    // MARK: - Properties

    private let delegate: ConverterViewControllerDelegate?

    private let repository: ConverterRepositoryType

    var valueOfRequestPickerView: Double = 0

    var valueOfResultPickerView: Double = 0


    // MARK: - Initializer

    init(repository: ConverterRepositoryType, delegate: ConverterViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var resultText: ((String) -> Void)?

    var visibleRates: (([String]) -> Void)?

    var selectedRequestRateValueText: ((String) -> Void)?

    var selectedResultRateValueText: ((String) -> Void)?

    var initialValuetextField: ((String) -> Void)?

    var selectedRequestCurrencyName: ((String) -> Void)?

    var selectedResultCurrencyName: ((String) -> Void)?


    var currencyRates: [Rate] = [] {
        didSet {
            let keys: [String] = currencyRates.map { $0.key }.sorted(by: { $0 < $1 })
            self.visibleRates?(keys)
        }
    }

    private var valueToConvert: Double = 0 {
        didSet {
            initialValuetextField?("Taux de conversion : \(valueToConvert)")
        }
    }

    private var result = "" {
        didSet {
            resultText?(result)
        }
    }

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultText?("")
        repository.getCurrency(callback: { [weak self] currency in
            self?.initCurrencyRates(from: currency)
        })
    }

    func didTapInitialValuetextField(valueFromTextField: Double) {
        let value = valueFromTextField
        valueToConvert = value
    }

    func didSelectCurrency(at index: Int, for type: ConverterType) {

        guard index < currencyRates.count else { return }
        let rate = currencyRates[index]

        switch type {
        case .request:
            selectedRequestRateValueText?("Taux de conversion : \(Double(round(100*rate.value)/100))")
            valueOfRequestPickerView = rate.value

        case .result:
            selectedResultRateValueText?("Taux de conversion : \(Double(round(100*rate.value)/100))")
            valueOfResultPickerView = rate.value
        }

        if valueOfRequestPickerView == 1.0 {
            let valueFromEuro = convertFromEuro(value: valueToConvert, rate: valueOfResultPickerView)
            result = ("\(Double(round(100*valueFromEuro)/100))")
        } else {
            let valueToEuro = convertToEuro(value: valueToConvert, rate: valueOfRequestPickerView)
            result = ("\(Double(round(100*valueToEuro)/100))")
        }
    }

    // MARK: - Private Functions

    func didPressConvert(value: String, origin: String, destination: String) {
        repository.convert(fromValue: value, from: origin, to: destination, callback: { text in
            self.resultText?(text)
        })
    }

    // MARK: - Private Functions

    private func initCurrencyRates(from currency: Currency) {
        let sorted = currency.rates.sorted { $0.key < $1.key }
        currencyRates = sorted.map { Rate(key: $0.key, value: $0.value) }
        if let value = currencyRates.first?.value {
            selectedRequestRateValueText?("\(Double(round(100*value)/100))")
            selectedResultRateValueText?("\(Double(round(100*value)/100))")
        }
    }

   private func convertFromEuro(value: Double, rate: Double) -> Double {

        return value * rate
    }

   private func convertToEuro(value: Double, rate: Double) -> Double {
        return value / rate
    }

}





