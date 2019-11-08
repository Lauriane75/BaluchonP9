//
//  Currency.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 24/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let success = true
    let timestamp = 1571841846
    let base = "EUR"
    let date = "2019-11-08"
    let rates: [String: Double]
}
