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
    
    var currency: Currency!
    var isSuccess = true
    
    func getCurrency(callback: @escaping (Currency) -> Void, error: @escaping (() -> Void)) {
        if isSuccess {
            callback(Currency(rates: ["EUR" : 1.0]))
        } else {
            error()
        }
    }
    
}

final class ConverterViewModelTests: XCTestCase {
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenselectedRequestRateValueIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        let expectation = self.expectation(description: "selectedRequestRateValue should return 1.0")
        
        viewModel.selectedRequestRateValue = { text in
            XCTAssertEqual(text, "1.0")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenselectedResultRateValueIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "selectedResultRateValue should return 1.0")
        
        viewModel.selectedResultRateValue = { text in
            XCTAssertEqual(text, "1.0")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThentextFieldPlaceHolderIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "textFieldPlaceHolder should return Entrez une valeur à convertir et swipez votre devise")
        
        viewModel.placeHolderTextField = { text in
            XCTAssertEqual(text, "Exemple : 100")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
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
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenVisibleRequestCurrencyNameIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "visibleRequestCurrencyName return EUR")
        viewModel.visibleRequestCurrencyName = { text in
            XCTAssertEqual(text, ["EUR"])
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_GivenConverterViewModel_WhenViewDidLoad_ThenVisibleResultCurrencyNameIsCorrectlyLoaded() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "visibleResultCurrencyName return EUR")
        viewModel.visibleResultCurrencyName = { text in
            XCTAssertEqual(text, ["EUR"])
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_GivenConverterViewModel_WhenTapAValueThenInitialValueTextFieldTextIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "Initial value textField is correctly returned")
        
        viewModel.initialValuetextField = { initialValue in
            XCTAssertEqual(initialValue, "10.0")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_GivenViewModelWithNoService_WhenViewDidLoadThenAlertError() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "No service connection")
        
        mockConverterRepository.isSuccess = false
        
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_GivenConverterViewModel_WhenDidSelectRequestRateThenSelectedRequestRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "selectedRequestRateValue correctly returned")
        
        var counter = 0
        
        viewModel.selectedRequestRateValue = { value in
            
            if counter == 1 {
                XCTAssertEqual(value, "Taux de conversion : 1.0")
                expectation.fulfill()
            }
            counter += 1
            
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectRequestRate(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_GivenConverterViewModel_WhenDidSelectRequestRateThenSelectedResulttRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation = self.expectation(description: "selectedResultRateValue correctly returned")
        
        var counter = 0
        viewModel.selectedResultRateValue = { value in
            if counter == 1 {
                XCTAssertEqual(value, "Taux de conversion : 1.0")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectResultRate(at: 0)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_GivenConverterViewModel_EnterAValueToConvert_ThenTheValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        
        let expectation1 = self.expectation(description: "selectedRequestRateValue should return 1.0")
        let expectation2 = self.expectation(description: "selectedResultRateValue should return 1.0")
        let expectation3 = self.expectation(description: "resultText should return 10 €")
        
        var counter1 = 0
        
        viewModel.selectedRequestRateValue = { text in
            if counter1 == 1 {
                XCTAssertEqual(text, "Taux de conversion : 1.0")
                expectation1.fulfill()
            }
            counter1 += 1
        }
        
        var counter2 = 0
        
        viewModel.selectedResultRateValue = { text in
            if counter2 == 1 {
            XCTAssertEqual(text, "Taux de conversion : 1.0")
            expectation2.fulfill()
            }
            counter2 += 1
        }
        
        var counter3 = 0
        
        viewModel.resultText = { text in
            if counter3 == 1 {
                XCTAssertEqual(text, "10.0 €")
                expectation3.fulfill()
                
            }
        counter3 += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectRequestRate(at: 0)
        viewModel.didSelectResultRate(at: 0)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
