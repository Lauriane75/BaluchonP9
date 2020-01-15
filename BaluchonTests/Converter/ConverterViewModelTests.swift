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
            callback(Currency(date: "2019-12-18", rates: ["EUR": 1.0]))
        } else {
            error()
        }
    }
}

final class ConverterViewModelTests: XCTestCase {

    let repository = MockConverterRepository()

    func test_Given_ConverterViewModel_When_ViewDidLoad_Then_ReactivePropertiesAreDisplayed() {
        let viewModel = ConverterViewModel(repository: repository)

        viewModel.viewDidLoad()

        viewModel.titleLabel = { text in
            XCTAssertEqual(text, "Entrez une valeur à convertir et swipez votre devise")
        }
        viewModel.selectedRequestRateValue = { text in
            XCTAssertEqual(text, "1.0")
        }
        viewModel.selectedResultRateValue = { text in
            XCTAssertEqual(text, "1.0")
        }
        viewModel.placeHolderTextField = { text in
            XCTAssertEqual(text, "Exemple : 100")
        }
        viewModel.resultText = { text in
            XCTAssertEqual(text, "0.0 €")
        }
        viewModel.visibleRequestCurrencyName = { text in
            XCTAssertEqual(text, ["EUR"])
        }
        viewModel.visibleResultCurrencyName = { text in
            XCTAssertEqual(text, ["EUR"])
        }
    }

    func test_Given_ConverterViewModel_When_TapAValue_Then_InitialValueTextFieldIsCorrectyReturned() {
        let viewModel = ConverterViewModel(repository: repository)

        viewModel.viewDidLoad()

        viewModel.didTapInitialValuetextField(valueFromTextField: 10)

        viewModel.initialValuetextField = { initialValue in
            XCTAssertEqual(initialValue, "10.0")
        }
    }

    func test_Given_ViewModelWithNoService_When_ViewDidLoad_Then_AlertError() {
        let viewModel = ConverterViewModel(repository: repository)

        let expectation = self.expectation(description: "No service connection")

        repository.isSuccess = false

        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Erreur de connexion",
                                          message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ConverterViewModel_When_DidSelectRequestRate_Then_SelectedRequestRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)

        let expectation = self.expectation(description: "SelectedRequestRateValue Is Correcty Returned")

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

    func test_Given_ConverterViewModel_When_DidSelectRequestRateEUR_Then_SelectedResultRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)

        let expectation = self.expectation(description: "SelectedResultRateValue Is Correcty Returned")

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

//    func
    // test_Given_ConverterViewModel_When_DidSelectRequestRateGBP_Then_SelectedRequestRateValueIsCorrectyReturned() {
//        let mockConverterRepository = MockConverterRepository()
//        let viewModel = ConverterViewModel(repository: mockConverterRepository)
//        
//        let expectation = self.expectation(description: "SelectedResultRateValue Is Correcty Returned")
//        var counter = 0
//        
//        viewModel.selectedRequestRateValue = { value in
//            if counter == 1 {
//                XCTAssertEqual(value, "Taux de conversion : 0.85")
//                expectation.fulfill()
//            }
//            counter += 1
//        }
//        
//        viewModel.viewDidLoad()
//        
//        viewModel.didSelectRequestRate(at: 1)
//        
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }

    func test_Given_ConverterViewModel_When_DidSelectRequestRateGBP_Then_SelectedResulttRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)

        viewModel.viewDidLoad()
        viewModel.didSelectResultRate(at: 1)

        viewModel.selectedResultRateValue = { value in
            XCTAssertEqual(value, "Taux de conversion : 0.85")
        }
    }

    func test_Given_ConverterViewModel_When_DidSelectRequestRateJPY_Then_SelectedRequestRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)

        viewModel.viewDidLoad()

        viewModel.didSelectRequestRate(at: 2)

        viewModel.selectedRequestRateValue = { value in
            XCTAssertEqual(value, "Taux de conversion : 121.84")
        }
    }

    func test_Given_ConverterViewModel_When_DidSelectRequestRateJPY_Then_SelectedResulttRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)

        viewModel.viewDidLoad()
        viewModel.didSelectResultRate(at: 2)

        viewModel.selectedResultRateValue = { value in
            XCTAssertEqual(value, "Taux de conversion : 121.84")
        }
    }

    func test_Given_ConverterViewModel_When_DidSelectRequestRateUSD_Then_SelectedRequestRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didSelectRequestRate(at: 3)
        viewModel.selectedRequestRateValue = { value in
            XCTAssertEqual(value, "Taux de conversion : 1.11")
        }
    }

    func test_GivenConverterViewModel_When_DidSelectRequestRateUSD_Then_SelectedResulttRateValueIsCorrectyReturned() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didSelectResultRate(at: 3)
        viewModel.selectedResultRateValue = { value in
            XCTAssertEqual(value, "Taux de conversion : 1.11")
        }
    }

    func test_Given_RequestRateIsEURAndResultRateIsEUR_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectRequestRate(at: 0)
        viewModel.didSelectResultRate(at: 0)
        viewModel.resultText = { text in
            XCTAssertEqual(text, "10.0 €")
        }
    }

    func test_Given_RequestRateIsGBPAndResultRateIsEUR_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectRequestRate(at: 1)
        viewModel.resultText = { text in
            XCTAssertEqual(text, "11.76 €")
        }
    }

    func test_Given_RequestRateIsEURAndResultRateIsGBP_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectResultRate(at: 1)
        viewModel.resultText = { text in
            XCTAssertEqual(text, "£ 8.5")
        }
    }
    func test_Given_RequestRateIsJPYAndResultRateIsEUR_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectRequestRate(at: 2)
        viewModel.resultText = { text in
            XCTAssertEqual(text, "0.08 €")
        }
    }

    func test_Given_RequestRateIsEURAndResultRateIsJPY_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectResultRate(at: 2)
        viewModel.resultText = { text in
            XCTAssertEqual(text, "1217.9 ¥")
        }
    }

    func test_Given_RequestRateIsUSDAndResultRateIsEUR_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.didSelectRequestRate(at: 3)
        viewModel.resultText = { text in
            XCTAssertEqual(text, "9.0 €")
        }
    }

    func test_Given_RequestRateIsEURAndResultRateIsUSD_When_EnterAValueToConvert_Then_ValueIsConverted() {
        let mockConverterRepository = MockConverterRepository()
        let viewModel = ConverterViewModel(repository: mockConverterRepository)
        viewModel.viewDidLoad()
        viewModel.didTapInitialValuetextField(valueFromTextField: 10)
        viewModel.initialValuetextField = { text in
            XCTAssertEqual(text, "10")
        }
        viewModel.didSelectResultRate(at: 3)
        viewModel.selectedResultRateValue = { text in
            XCTAssertEqual(text, "1.11")
        }
        viewModel.resultText = { text in
            XCTAssertEqual(text, "$ 11.12")
        }
    }
}
