//
//  Translation.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 01/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.


import Foundation

// MARK: - Translation
struct Translation: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [TranslationElement]
}

// MARK: - TranslationElement
struct TranslationElement: Codable {
    let translatedText: String
}


