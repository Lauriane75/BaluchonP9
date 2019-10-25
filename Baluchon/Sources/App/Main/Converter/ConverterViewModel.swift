//
//  ConverterViewModel.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 18/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

final class ConverterViewModel {

    // MARK: - Properties

    private let delegate: ConverterViewControllerDelegate?

    private let repository: ConverterRepositoryType

<<<<<<< 0b78be2007c2c8c01f0f906622406bf8d26a0ae8:BaluchonApp/Baluchon/Sources/App/Main/Converter/ConverterViewModel.swift
=======
    var valueOfRequestPickerView: Double = 0

    var valueOfResultPickerView: Double = 0

    var nameOfRequestPickerView: String = ""

    var nameOfResultPickerView: String = ""


>>>>>>> Format rate numbers:BaluchonApp/Baluchon/Sources/App/Converter/ConverterViewModel.swift
    // MARK: - Initializer

    init(repository: ConverterRepositoryType, delegate: ConverterViewControllerDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var resultText: ((String) -> Void)?

    var visibleRequestRates: (([String]) -> Void)?

    var visibleResultRates: (([String]) -> Void)?

    var selectedRequestRateValueText: ((String) -> Void)?

    var selectedResultRateValueText: ((String) -> Void)?


    var requestRates: [Rate] = [] {
        didSet {
            let keys: [String] = requestRates.map { $0.key }.sorted(by: { $0 < $1 })
            self.visibleRequestRates?(keys)
        }
    }

    var resultRates: [Rate] = [] {
        didSet {
            let keys: [String] = resultRates.map { $0.key }.sorted(by: { $0 < $1 })
            self.visibleResultRates?(keys)
        }
    }

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultText?("")
        repository.getCurrency(callback: { [weak self] currency in
            self?.initRequestRates(from: currency)
            self?.initResultRates(from: currency)
        })
    }

<<<<<<< 0b78be2007c2c8c01f0f906622406bf8d26a0ae8:BaluchonApp/Baluchon/Sources/App/Main/Converter/ConverterViewModel.swift
    private func initRequestRates(from currency: Currency) {
        requestRates = currency.rates.map { Rate(key: $0.key, value: $0.value) }
        if let value = requestRates.first?.value {
            selectedRequestRateValueText?("\(value)")
=======
    func didTapInitialValuetextField(valueFromTextField: Double) {
        let value = valueFromTextField
        valueToConvert = value
        print("V0\(valueToConvert)")
    }

    func didSelectCurrency(at index: Int, for type: ConverterType) {

        guard index < currencyRates.count else { return }
        let rate = currencyRates[index]

        switch type {
        case .request:
            selectedRequestRateValueText?("\(Double(round(100*rate.value)/100))")
            valueOfRequestPickerView = rate.value
            nameOfRequestPickerView = rate.key
            print("name request \(valueOfRequestPickerView)")
        case .result:
            selectedResultRateValueText?("\(Double(round(100*rate.value)/100))")
            valueOfResultPickerView = rate.value
            nameOfResultPickerView = rate.key
            print("name result \(valueOfResultPickerView)")

>>>>>>> Format rate numbers:BaluchonApp/Baluchon/Sources/App/Converter/ConverterViewModel.swift
        }
    }

<<<<<<< 0b78be2007c2c8c01f0f906622406bf8d26a0ae8:BaluchonApp/Baluchon/Sources/App/Main/Converter/ConverterViewModel.swift
    private func initResultRates(from currency: Currency) {
        resultRates = currency.rates.map { Rate(key: $0.key, value: $0.value) }
        if let value = resultRates.first?.value {
            selectedResultRateValueText?("\(value)")
=======
        if valueOfRequestPickerView == 1.0 {
            let valueFromEuro = convertFromEuro(value: valueToConvert, rate: valueOfResultPickerView)
            result = "\(valueFromEuro)"
        } else {
            let valueToEuro = convertToEuro(value: valueToConvert, rate: valueOfRequestPickerView)
            result = "\(valueToEuro)"
>>>>>>> Format rate numbers:BaluchonApp/Baluchon/Sources/App/Converter/ConverterViewModel.swift
        }
    }

    func didPressConvert(text: String, from origin: String, to destination: String) {
        repository.convert(fromValue: text, from: origin, to: destination, callback: { text in
            self.resultText?(text)
        })
    }

<<<<<<< 0b78be2007c2c8c01f0f906622406bf8d26a0ae8:BaluchonApp/Baluchon/Sources/App/Main/Converter/ConverterViewModel.swift
    func didSelectRequestRate(at index: Int) {
        guard index < requestRates.count else { return }
        let rate = requestRates[index]
        selectedRequestRateValueText?("\(rate.value)")
=======
    // MARK: - Private Functions

    private func initCurrencyRates(from currency: Currency) {
        let sorted = currency.rates.sorted { $0.key < $1.key }
        currencyRates = sorted.map { Rate(key: $0.key, value: $0.value) }
        if let value = currencyRates.first?.value {
            selectedRequestRateValueText?("\(Double(round(100*value)/100))")
            selectedResultRateValueText?("\(Double(round(100*value)/100))")
        }
>>>>>>> Format rate numbers:BaluchonApp/Baluchon/Sources/App/Converter/ConverterViewModel.swift
    }

    func didSelectResultRate(at index: Int) {
        guard index < resultRates.count else { return }
        let rate = resultRates[index]
        selectedResultRateValueText?("\(rate.value)")
    }

    private func convertFromEuro(value: Double, rate: Double) -> Double {
        return value * rate
    }

    private func convertToEuro(value: Double, rate: Double) -> Double {
        return value / rate
    }

//    func convert(value: Double, from: String, to: String) -> Double {
//        return
//    }
}



struct Rate {
    let key: String
    let value: Double
}


