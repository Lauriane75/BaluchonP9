//
//  HTTPClient.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol HTTPClientType {
    func request<T>(type: T.Type,
                    requestType: RequestType,
                    url: URL,
                    cancelledBy token: RequestCancelationToken,
                    callback: @escaping (T) -> Void) where T: Codable
}

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
}

final class HTTPClient: HTTPClientType {

    private let engine: HTTPEngine

    private let decoder: JSONDecoder

    init() {
        self.engine = HTTPEngine()
        self.decoder = JSONDecoder()
    }

    func request<T>(type: T.Type, requestType: RequestType, url: URL, cancelledBy token: RequestCancelationToken, callback: @escaping (T) -> Void) where T: Codable {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue

        engine.send(request: request, cancelledBy: token) { (data, response, error) in
            guard let data = data else { return }
            self.decodeJSON(type: T.self, data: data, callback: callback)
        }
    }

    private func decodeJSON<T>(type: T.Type, data: Data, callback: @escaping (T) -> Void) where T: Codable {
        guard let decodedData = try? decoder.decode(type.self, from: data) else {
            print("Unable to decode: \(type.self)")
            return
        }
        callback(decodedData)
    }
}
