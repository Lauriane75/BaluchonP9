//
//  Currency.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 24/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let base = "EUR"
    let date: String
    let rates: [String: Double]
}
