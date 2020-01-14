//
//  HTTPClient.swift
//  Baluchon
//
//  Created by Bertrand BLOC'H on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol HTTPClientType {
    func request<T>(type: T.Type, requestType: RequestType, url: URL, cancelledBy token: RequestCancelationToken, completion: @escaping (T) -> Void) where T: Codable
}

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
}

class HTTPClient: HTTPClientType {

    private let engine: HTTPEngine

    private let jsonDecoder: JSONDecoder

    init(engine: HTTPEngine = HTTPEngine.init(configuration: .default)) {
        self.engine = engine
        self.jsonDecoder = JSONDecoder()
    }

    func request<T>(type: T.Type, requestType: RequestType, url: URL, cancelledBy token: RequestCancelationToken, completion: @escaping (T) -> Void) where T: Codable {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue

        engine.send(request: request,
                    cancelledBy: token) { (data, httpUrlResponse, error) in
                        guard let data = data else { return }
                        self.decodeJSON(type: T.self, data: data, completion: completion)
        }
    }

    private func decodeJSON<T>(type: T.Type, data: Data, completion: @escaping (T) -> Void) where T: Decodable {
        guard let decodedData = try? jsonDecoder.decode(type.self, from: data) else { print("Decoder was unable to decode: \(type.self)"); return }
        completion(decodedData)
    }
}
