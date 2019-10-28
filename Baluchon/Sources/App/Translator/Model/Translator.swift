//
//  Translator.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 01/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.


import Foundation

// MARK: - Translator
struct Translator: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translator]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}


