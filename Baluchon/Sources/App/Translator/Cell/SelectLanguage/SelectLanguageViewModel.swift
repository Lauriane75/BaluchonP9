//
//  SelectLanguageViewModel.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 04/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

struct LanguageConfiguration: Equatable {
    let nameLanguage: String
    let ISOCode: String
}

protocol SelectLanguageViewModelDelegate: class {
    func didPressLanguageTypeButton(with language: SelectLanguageType)
}

final class SelectLanguageViewModel {
    
    // MARK: Private properties
    
    private weak var delegate: SelectLanguageViewModelDelegate?
    
    private var languageItems: [LanguageItem] = [] {
        didSet {
            let items = languageItems.map { ItemLabel(languageItem: $0) }
            visibleItems?(items)
        }
    }
    
    private let repository: SelectLanguageRepositoryType
    
    private let languageType: LanguageType
    
    // MARK: - Initializer
    
    init(languageType: LanguageType,
         repository: SelectLanguageRepositoryType,
         delegate: SelectLanguageViewModelDelegate?) {
        self.languageType = languageType
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    enum ItemLabel: Equatable {
        case language(_ titleLabel: String)
    }
    
    fileprivate enum LanguageItem: Equatable {
        case language(_ languageStruct: LanguageConfiguration)
    }
    
    private class func initialItems(from languages: [Language]) -> [LanguageItem] {
        return languages.map {
            return .language(LanguageConfiguration(nameLanguage: $0.value,
                                                   ISOCode: $0.key))
        }
    }
    
    // MARK: - Outputs
        
    var visibleItems: (([ItemLabel]) -> Void)?
    
    var nextScreen: ((NextScreen) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        repository.requestLanguages { [weak self] (languages) in
            self?.languageItems = SelectLanguageViewModel.initialItems(from: languages)
        }
    }
    
    func didSelectItem(at index: Int) {
        guard index < languageItems.count else {
            return
        }
        let item = languageItems[index]
        if case .language(languageStruct: let languageStruct) = item {
            switch languageType {
            case .request:
                delegate?.didPressLanguageTypeButton(with: .request(languageStruct.nameLanguage, languageStruct.ISOCode))
            case .result:
                delegate?.didPressLanguageTypeButton(with: .result(languageStruct.nameLanguage, languageStruct.ISOCode))
            }
        }
    }
}

extension SelectLanguageViewModel.ItemLabel {
    fileprivate init(languageItem: SelectLanguageViewModel.LanguageItem) {
        switch languageItem {
        case .language(languageStruct: let languageStruct) :
            self = .language(languageStruct.nameLanguage)
        }
    }
}
