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

//    private let delegate: ConverterViewControllerDelegate?

    private let repository: ConverterRepositoryType

    var valueOfRequestPickerView: Double = 0

    var valueOfResultPickerView: Double = 0
    
    var currencyOfRequestPickerView: String = ""
    
    var currencyOfResultPickerView:String = ""


    // MARK: - Initializer

    init(repository: ConverterRepositoryType) {
        self.repository = repository
//        self.delegate = delegate
    }

    // MARK: - Outputs

    var resultText: ((String) -> Void)?

    var visibleRates: (([String]) -> Void)?

    var selectedRequestRateValueText: ((String) -> Void)?

    var selectedResultRateValueText: ((String) -> Void)?

    var initialValuetextField: ((String) -> Void)?
    
    var placeHolderTextField: ((String) -> Void)?
    
    var nextScreen: ((NextScreen) -> Void)?
    

    var currencyRates: [Rate] = [] {
        didSet {
            let keys: [String] = currencyRates.map { $0.key }.sorted(by: { $0 < $1 })
            self.visibleRates?(keys)
        }
    }

    private var valueToConvert: Double = 0 {
        didSet {
            initialValuetextField?("\(valueToConvert)")
        }
    }

    private var result = "" {
        didSet {
            resultText?(result)
        }
    }

    // MARK: - Inputs

    func viewDidLoad() {
        self.resultText?("0.0 €")
        self.placeHolderTextField?("Entrez une valeur à convertir")
        repository.getCurrency(callback: { [weak self] currency in
            self?.initCurrencyRates(from: currency)
            }, error: { [weak self] in
            self?.nextScreen?(.alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
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
            currencyOfRequestPickerView = rate.key
            
        case .result:
            selectedResultRateValueText?("Taux de conversion : \(Double(round(100*rate.value)/100))")
            valueOfResultPickerView = rate.value
            currencyOfResultPickerView = rate.key
        }
                
        let convertedValueResult = convertedValue(valueToConvert: valueToConvert, topRateValue: valueOfRequestPickerView, bottomRateValue: valueOfResultPickerView)
            if currencyOfResultPickerView == "EUR" && valueOfResultPickerView == 1 {
                    result = ("\(Double(round(100*convertedValueResult)/100)) €")
            }
            if currencyOfResultPickerView == "USD" {
                    result = ("$ \(Double(round(100*convertedValueResult)/100))")
            }
            if currencyOfResultPickerView == "GBP" {
                    result = ("£ \(Double(round(100*convertedValueResult)/100))")
            }
            if currencyOfResultPickerView == "JPY" {
                    result = ("\(Double(round(100*convertedValueResult)/100)) ¥")
        }
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

    private func convertedValue(valueToConvert: Double, topRateValue: Double, bottomRateValue: Double) -> Double {
        return (valueToConvert / topRateValue) * bottomRateValue
     }

}





