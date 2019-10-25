//
//  EnglishLanguage.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 01/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.


import Foundation

struct EnglishLanguage: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

