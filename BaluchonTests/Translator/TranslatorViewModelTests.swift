//
//  TranslatorViewModelTests.swift
//  BaluchonTests
//
//  Created by Lauriane Haydari on 06/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//
import XCTest
@testable import Baluchon

enum MockedError: Error {
    case repositoryError
}


fileprivate final class MockTranslatorRepository: TranslatorRepositoryType {
    
    func getTranslation(for text: String, from originLanguage: String, to destinationLanguage: String, callback success: @escaping ((String?, Error?) -> Void)) {
        isSuccess ? success(returnedText, nil) : success(nil, MockedError.repositoryError)
    }
    
    var isSuccess = true
    var returnedText = ""
    
}

fileprivate final class MockTranslatorViewModelDelegate: TranslatorViewModelDelegate {
    
    var languagetype: LanguageType = .request
    
    func showLanguageChoices(for type: LanguageType) {
        self.languagetype = type
    }
}

final class TranslatorViewModelTests: XCTestCase {
    
    
    func test_Given_TranslatorView_When_ViewDidLoad_Then_RequestLanguageTextButtonIsDisplayed() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "French", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        let expectation = self.expectation(description: "Returned requestLanguageTextButton")
        
        viewModel.requestLanguageTextButton = { text in
            XCTAssertEqual(text, translationType.initialLanguage.nameLanguage)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_Given_TranslatorView_When_ViewDidLoad_Then_ResultLanguageTextButtonIsDisplayed() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "Anglais", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        let expectation = self.expectation(description: "Returned resultLanguageTextButton")
        
        
        viewModel.resultLanguageTextButton = { text in
            XCTAssertEqual(text, translationType.destinationLanguage.nameLanguage)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    //
    func test_Given_TranslatorView_When_ViewDidLoad_Then_IsReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "Anglais", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslatButton(for: "Bonjour")
                
        viewModel.requestTextField = { text in
            XCTAssertEqual(text, "Bonjour")
        }
    }
    
    func test_Given_TranslatorView_When_DidSelectRequestLanguageButton_Then_LanguageTypeIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "Anglais", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectLanguageType(for: LanguageType.request)
        
        XCTAssertEqual(mockDelegate.languagetype, .request)
    }
    
    func test_Given_TranslatorView_When_DidSelectResultLanguageButton_Then_LanguageTypeIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "Anglais", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectLanguageType(for: LanguageType.result)
        
        XCTAssertEqual(mockDelegate.languagetype, .result)
    }
    
    func testGivenTranslatorViewFromFrenchToEnglishWhenDidPressTranslateButtonThenTranslationIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "Anglais", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        mockRepository.isSuccess = true
        mockRepository.returnedText = "Hello world"
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.resultText = { text in
            if counter == 2 {
                XCTAssertEqual(text, "Hello world")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslatButton(for: "Bonjour monde")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_Given_TranslatorViewFromFrenchToDeutch_When_DidPressTranslateButton_Then_TranslationIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "French", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "Dutch", ISOCode: "de", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        mockRepository.isSuccess = true
        mockRepository.returnedText = "Hallo"
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.resultText = { text in
            if counter == 2 {
                XCTAssertEqual(text, "Hallo")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslatButton(for: "Bonjour")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_Given_TranslatorViewFromEnglishToFrench_When_DidPressTranslateButton_Then_TranslationIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "English", ISOCode: "en", text: ""), destinationLanguage: (nameLanguage: "French", ISOCode: "fr", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        mockRepository.isSuccess = true
        mockRepository.returnedText = "Bonjour monde"
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.resultText = { text in
            if counter == 2 {
                XCTAssertEqual(text, "Bonjour monde")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslatButton(for: "Hello world")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_Given_TranslatorViewFromEnglishToSpanish_When_DidPressTranslateButton_Then_TranslationIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "English", ISOCode: "en", text: ""), destinationLanguage: (nameLanguage: "Spanish", ISOCode: "sp", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        mockRepository.isSuccess = true
        mockRepository.returnedText = "Hola Mundo"
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.resultText = { text in
            if counter == 2 {
                XCTAssertEqual(text, "Hola Mundo")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslatButton(for: "Hello world")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_Given_ViewModelWithNoService_When_ViewDidLoad_Then_AlertError() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "English", ISOCode: "en", text: ""), destinationLanguage: (nameLanguage: "Spanish", ISOCode: "sp", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        let expectation = self.expectation(description: "No service connection")
        
        mockRepository.isSuccess = false
        
        viewModel.nextScreen = { screen in
            XCTAssertEqual(screen, .alert(title: "Erreur de connexion", message: "Veuillez vous assurer de votre connexion internet et retenter l'action"))
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslatButton(for: "Hello")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
