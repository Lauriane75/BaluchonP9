//
//  LanguagesRepository.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 04/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation
import SwiftGoogleTranslate

struct Language {
    let key: String
    let value: String
}

protocol SelectLanguageRepositoryType: class {
    func requestLanguages(callback: @escaping ([Language]) -> Void)
}

final class SelectLanguageRepository: SelectLanguageRepositoryType {

    // MARK: - Properties

    private var translator: SwiftGoogleTranslate

    // MARK: - Initializer

    init() {
        translator = SwiftGoogleTranslate.shared
        translator.start(with: "AIzaSyBP0KxCjiYHKryO2NlZrsb2RYhqzHTlrog")
    }

    // MARK: - Requests

    func requestLanguages(callback: @escaping ([Language]) -> Void) {
        translator.languages { (languages, _) in guard let languages = languages else { return }
            let result = languages.map { Language(key: $0.language, value: $0.name) }
            callback(result)
        }
    }
}
