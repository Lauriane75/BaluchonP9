//
//  NetworkTests.swift
//  BaluchonTests
//
//  Created by Lauriane Haydari on 09/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

class FakeObject: Codable {
    
}


final class NetworkTests: XCTestCase {
    
    private let cancellationToken = RequestCancelationToken()

    private let client = HTTPClient()

    func testWhenSendingGetRequest_itReceivesValidResponse() {
        let expectation = self.expectation(description: "received data response")

        let request = HTTPClient()
        request.request(type: FakeObject.self, requestType: .GET, url: URL(string: "http://api.openweathermap.org/data/2.5/weather?id=Paris&units2988507=metric&appid=916792210f24330ed8b2f3f603669f4d")!, cancelledBy: cancellationToken) { response in
            
        }
    }

    
}

//class HTTPClientSpy: HTTPClientType {
//    func request<T>(type: T.Type, requestType: RequestType, url: URL, cancelledBy token: RequestCancelationToken, completion: @escaping (T) -> Void) where T : Decodable, T : Encodable {
//        completion()
//    }
//
//
//}
