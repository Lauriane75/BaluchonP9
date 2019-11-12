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
        callback(Currency(date: "", rates: ["EUR" : 1.0]))
    }
}


final class ConverterViewModelTests: XCTestCase {
    
     func test_GivenConverterViewModel_WhenViewDidLoad_ThenResultTextIsCorrectlyLoaded() {
            let mockConverterRepository = MockConverterRepository()
            let viewModel = ConverterViewModel(repository: mockConverterRepository)
            

            let expectation = self.expectation(description: "resultText return 0.0 €")
            viewModel.resultText = { text in
                XCTAssertEqual(text, "0.0 €")
                expectation.fulfill()
            }
  
            viewModel.viewDidLoad()
            
            waitForExpectations(timeout: 1, handler: nil)
                                
        }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThentextFieldPlaceHolderIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "textFieldPlaceHolder should return Entrez une valeur à convertir")

        viewModel.placeHolderTextField = { text in
            XCTAssertEqual(text, "Entrez une valeur à convertir")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
                            
    }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenselectedRequestRateValueTextIsCorrectlyLoaded() {
            let mockConverterRepository = MockConverterRepository()
            let viewModel = ConverterViewModel(repository: mockConverterRepository)
            

            let expectation = self.expectation(description: "selectedRequestRateValueText should return 1.0")

      
            viewModel.selectedRequestRateValueText = { text in
                XCTAssertEqual(text, "1.0")
                expectation.fulfill()
            }

            viewModel.viewDidLoad()
            
            waitForExpectations(timeout: 1, handler: nil)
                                
        }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenselectedRequestCurrencyNameIsCorrectlyLoaded() {
            let mockConverterRepository = MockConverterRepository()
            let viewModel = ConverterViewModel(repository: mockConverterRepository)

            let expectation = self.expectation(description: "selectedRequestCurrencyName should return Euro €")
 
          
            viewModel.selectedRequestCurrencyName = { text in
                XCTAssertEqual(text, "Euro €")
                expectation.fulfill()
            }
  
            viewModel.viewDidLoad()
            
            waitForExpectations(timeout: 1, handler: nil)
                                
        }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenselectedResultCurrencyNameIsCorrectlyLoaded() {
               let mockConverterRepository = MockConverterRepository()
               let viewModel = ConverterViewModel(repository: mockConverterRepository)

      
               let expectation = self.expectation(description: "selectedResultCurrencyName should return Euro €")
            
               viewModel.selectedResultCurrencyName = { text in
                   XCTAssertEqual(text, "Euro €")
                   expectation.fulfill()
               }
     
               viewModel.viewDidLoad()
               
               waitForExpectations(timeout: 1, handler: nil)
                                   
           }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenselectedResultRateValueTextIsCorrectlyLoaded() {
                let mockConverterRepository = MockConverterRepository()
                let viewModel = ConverterViewModel(repository: mockConverterRepository)

                let expectation = self.expectation(description: "selectedResultRateValueText should return 1.0")
           
                viewModel.selectedResultRateValueText = { text in
                    XCTAssertEqual(text, "1.0")
                    expectation.fulfill()
                }
                viewModel.viewDidLoad()
                
                waitForExpectations(timeout: 1, handler: nil)
                                    
        }
    
    func testExample() {
        let mockConverterRepository = MockConverterRepository()
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
