//
//  ConverterViewModelTests.swift
//  BaluchonTests
//
//  Created by Lauriane Haydari on 06/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

final class MockConverterRepository: ConverterRepositoryType {
    func getCurrency(callback: @escaping (Currency) -> Void, error: @escaping (() -> Void)) {
        callback(currency)
    }
    var currency: Currency!
    
    var isSuccess = true
    var returnedText = ""
}


final class ConverterViewModelTests: XCTestCase {
    
    func testGivenConverterViewModelWhenViewDidLoadThenViewIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        mockConverterRepository.currency = Currency(date: "", rates: ["EUR" : 1.0])
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation1 = self.expectation(description: "textFieldPlaceHolder should return Entrez une valeur à convertir")
        let expectation2 = self.expectation(description: "selectedRequestRateValueText should return 1.0")
        let expectation3 = self.expectation(description: "resultText return 0.0 €")
        let expectation4 = self.expectation(description: "selectedRequestCurrencyName should return Euro €")
        let expectation5 = self.expectation(description: "selectedResultCurrencyName should return Euro €")
        let expectation6 = self.expectation(description: "selectedRequestRateValueText should return 1.0")

        viewModel.placeHoldertextField = { text in
            XCTAssertEqual(text, "Entrez une valeur à convertir")
            expectation1.fulfill()
        }
        viewModel.selectedRequestRateValueText = { text in
            XCTAssertEqual(text, "1.0")
            expectation2.fulfill()
        }
        viewModel.resultText = { text in
            XCTAssertEqual(text, "0.0 €")
            expectation3.fulfill()
        }
        viewModel.selectedRequestCurrencyName = { text in
            XCTAssertEqual(text, "Euro €")
            expectation4.fulfill()
        }
        viewModel.selectedResultCurrencyName = { text in
            XCTAssertEqual(text, "Euro €")
            expectation5.fulfill()
        }
        viewModel.selectedRequestRateValueText = { text in
            XCTAssertEqual(text, "1.0")
            expectation6.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)

        viewModel.viewDidLoad()
                                
    }
    
    func testExample() {
        let mockConverterRepository = MockConverterRepository()
        mockConverterRepository.currency = Currency(date: "", rates: ["EUR" : 1.0])
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
         let expectation = self.expectation(description: "selectedRequestCurrencyName should return")
        
         viewModel.selectedRequestCurrencyName  = { text in
                      XCTAssertEqual(text, "Euro €")
                      expectation.fulfill()
                  }
            
         viewModel.viewDidLoad()
    
         waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    

    
    
}
