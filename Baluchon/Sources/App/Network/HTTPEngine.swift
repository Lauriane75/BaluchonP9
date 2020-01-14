//
//  HTTPEngine.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 20/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

typealias HTTPCompletionHander = (Data?, HTTPURLResponse?, Error?) -> Void

enum URLSessionEngineError: Error {
    case invalidURLResponseType
}

final class HTTPEngine {

    private let session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func send(request: URLRequest,
              cancelledBy token: RequestCancelationToken,
              callback: @escaping HTTPCompletionHander) {
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if urlResponse != nil, let httpURLResponse = urlResponse as? HTTPURLResponse {
                callback(data, httpURLResponse, nil)
            } else {
                callback(data, nil, URLSessionEngineError.invalidURLResponseType)
            }
        }
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }

    deinit {
        session.invalidateAndCancel()
    }
}
