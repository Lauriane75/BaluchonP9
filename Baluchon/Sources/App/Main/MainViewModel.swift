//
//  MainViewModel.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

final class MainViewModel {

    // MARK: - Properties

    private let delegate: MainViewControllerDelegate?

    // MARK: - Initializer

    init(delegate: MainViewControllerDelegate?) {
        self.delegate = delegate
    }

    // MARK: - Inputs

    func viewDidLoad() {
        translatorText?("TRANSLATOR")
        converterText?("CONVERTER")
        weatherText?("WEATHER")
    }

    func didPressTranslatorButton() {
        delegate?.didPressTranslatorButton()
    }

    func didPressConverterButton() {
        delegate?.didPressConverterButton()
    }
    
    func didPressWeatherButton() {
        delegate?.didPressWeatherButton()
    }

    // MARK: - Outputs

    var translatorText: ((String) -> Void)?
    var converterText: ((String) -> Void)?
    var weatherText: ((String) -> Void)?
}
