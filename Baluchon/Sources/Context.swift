//
//  Context.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 24/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

final class Context {

    let client: HTTPClientType
    

    init(client: HTTPClientType) {
        self.client = client
    }
}
