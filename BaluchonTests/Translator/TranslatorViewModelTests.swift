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
    
    func getTranslation(for text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping ((String?, Error?) -> Void)) {
        isSuccess ? callback(returnedText, nil) : callback(nil, MockedError.repositoryError)
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
    
    func testGivenTranslatorViewWhenViewDidLoadThenRequestTextAndResultTextAndRequestLanguageTextButtonAndResultLanguageTextButtonAreCorectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
       
        let expectation1 = self.expectation(description: "Returned empty text")
        let expectation2 = self.expectation(description: "Returned Text Language")
        let expectation3 = self.expectation(description: "Returned empty text")
        let expectation4 = self.expectation(description: "Returned Text Language")
        
        
        viewModel.requestText = { text in
            XCTAssertEqual(text, "")
            expectation1.fulfill()
        }
        
        viewModel.requestLanguageTextButton = { text in
            XCTAssertEqual(text, "Français")
            expectation2.fulfill()
        }
        
        viewModel.resultText = { text in
            XCTAssertEqual(text, "")
            expectation3.fulfill()
        }
        
        viewModel.resultLanguageTextButton = { text in
            XCTAssertEqual(text, "English")
            expectation4.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenTranslatorViewWhenDidSelectRequestLanguageButtonThenLanguageTypeIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectLanguageType(for: LanguageType.request)
        
        XCTAssertEqual(mockDelegate.languagetype, .request)
    }
    
    func testGivenTranslatorViewWhenDidSelectResultLanguageButtonThenLanguageTypeIsCorrectlyReturned() {
           let mockRepository = MockTranslatorRepository()
           let mockDelegate = MockTranslatorViewModelDelegate()
           let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))
           
           let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
           
           viewModel.viewDidLoad()
           
           viewModel.didSelectLanguageType(for: LanguageType.result)
           
           XCTAssertEqual(mockDelegate.languagetype, .result)
       }
    
    func testGivenTranslatorViewFromFrenchToEnglishWhenDidPressTranslateButtonThenTranslationIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))
        
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
    
    func testGivenTranslatorViewFromEnglishToFrenchWhenDidPressTranslateButtonThenTranslationIsCorrectlyReturned() {
        let mockRepository = MockTranslatorRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let translationType = TranslationType(initialLanguage: (nameLanguage: "English", ISOCode: "en", text: ""), destinationLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""))
        
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
    
    // error Alert test
//    func testGivenTranslatorViewModelWhenDidPressTranslateThenGetAnError() {
//        let mockRepository = MockTranslatorRepository()
//        let mockDelegate = MockTranslatorViewModelDelegate()
//        let translationType = TranslationType(initialLanguage: (nameLanguage: "Français", ISOCode: "fr", text: ""), destinationLanguage: (nameLanguage: "English", ISOCode: "en", text: ""))
//
//        let viewModel = TranslatorViewModel(repository: mockRepository, translationType: translationType, delegate: mockDelegate)
//
//        mockRepository.isSuccess = false
//
//        viewModel.viewDidLoad()
//
//        viewModel.didPressTranslatButton(for: "Bonjour")
//    }
    

}
