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

    private func initRequestRates(from currency: Currency) {
        requestRates = currency.rates.map { Rate(key: $0.key, value: $0.value) }
        if let value = requestRates.first?.value {
            selectedRequestRateValueText?("\(value)")
        }
    }

    private func initResultRates(from currency: Currency) {
        resultRates = currency.rates.map { Rate(key: $0.key, value: $0.value) }
        if let value = resultRates.first?.value {
            selectedResultRateValueText?("\(value)")
        }
    }

    func didPressConvert(text: String, from origin: String, to destination: String) {
        repository.convert(fromValue: text, from: origin, to: destination, callback: { text in
            self.resultText?(text)
        })
    }

    func didSelectRequestRate(at index: Int) {
        guard index < requestRates.count else { return }
        let rate = requestRates[index]
        selectedRequestRateValueText?("\(rate.value)")
    }

    func didSelectResultRate(at index: Int) {
        guard index < resultRates.count else { return }
        let rate = resultRates[index]
        selectedResultRateValueText?("\(rate.value)")
    }

    func didPressBackToMenu() {
        delegate?.didPressbackToMenu()
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


