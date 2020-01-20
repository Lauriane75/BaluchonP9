//
//  RequestCancelationToken.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 20/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

final class RequestCancelationToken {

    init() {}

    deinit {
        willDealocate?()
    }

    var willDealocate:(() -> Void)?
}
