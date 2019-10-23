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

    let currencySigns = ["EUR": "€", "USD": "$", "GBP": "£"]

    var fromCurrencySign = "EUR"
    var toCurrencySign = "EUR"

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

    var currencyRates: [Rate] = [] {
        didSet {
            let keys: [String] = currencyRates.map { $0.key }.sorted(by: { $0 < $1 })
            self.visibleRates?(keys)
        }
    }

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultText?("")
        repository.getCurrency(callback: { [weak self] currency in
            self?.initCurrencyRates(from: currency)
        })
    }

    func didPressConvert(value: Double, origin: String, destination: String) {
        repository.convert(value: value, from: origin, to: destination, callback: { text in
            self.resultText?(text)
        })
    }

    func didSelectCurrency(at index: Int, for type: ConverterType) {
        guard index < currencyRates.count else { return }
        let rate = currencyRates[index]
//        let originValue = String(rate.value)
//        let destinationValue = String(rate.value)

        switch type {
        case .request:
            selectedRequestRateValueText?("\(rate.value)")
        case .result:
            selectedResultRateValueText?("\(rate.value)")
        }
//        didPressConvert(value: , origin: originValue, destination: destinationValue)

    }

    // MARK: - Private Functions

    private func initCurrencyRates(from currency: Currency) {
        currencyRates = currency.rates.map { Rate(key: $0.key, value: $0.value) }
        if let value = currencyRates.first?.value {
            selectedRequestRateValueText?("\(value)")
            selectedResultRateValueText?("\(value)")

        }
    }

//    func convertFromEuro(value: Double, rate: Double) -> Double {
//        return value * rate
//    }
//
//    func convertToEuro(value: Double, rate: Double) -> Double {
//        return value / rate
//    }
//
//    func convert(value: Double, from: String, to: String, from currency: Currency) -> Double {
//        if from != "EUR" {
//            var rate = Double((currency.rates[from])!)
//            let valueToEuro = convertToEuro(value: value, rate: rate)
//            rate = Double((currency.rates[to])!)
//            let convertValue = convertFromEuro(value: valueToEuro, rate: rate)
//            print(convertValue)
//
//            return convertValue
//
//        } else {
//            let rate = Double((currency.rates[to])!)
//            let convertValue = convertFromEuro(value: value, rate: rate)
//            print(convertValue)
//
//            return convertValue
//        }
//    }

//    func showResult() -> Double {
//        CurrencyService.shared.getCurrency {(currency) in
//            if let c = currency, let text = self.requestTextField.text, let value = Double(text) {
//                let result = c.convert(value: value, from: self.fromSymbol, to: self.toSymbol)
//                self.resultLabel.text = String(result)
//            }
//        }
//    }
}


