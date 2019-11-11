//
//  SelectLanguageViewModelTests.swift
//  BaluchonTests
//
//  Created by Lauriane Haydari on 11/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import XCTest
@testable import Baluchon

fileprivate final class MockSelectLanguageRepository: SelectLanguageRepositoryType {
    
    var result: [Language] = []
    
    func requestLanguages(callback: @escaping ([Language]) -> Void) {
        callback(result)
    }
}

fileprivate final class MockSelectLanguageViewControllerDelegate: SelectLanguageViewModelDelegate {
    
    var language: SelectLanguageType? = nil
    
    func didPressLanguageTypeButton(with language: SelectLanguageType) {
        self.language = language
    }
}

final class SelectLanguageViewModelTests: XCTestCase {
    
    func test_GivenViewModel_WhenViewDidLoad_ThenRequestVisibleItemsIsCorrectlyReturned() {
        let mockRepository = MockSelectLanguageRepository()
        let delegate = MockSelectLanguageViewControllerDelegate()
        let viewModel = SelectLanguageViewModel(languageType: .request,
                                          repository: mockRepository,
                                          delegate: delegate)
        let expectation = self.expectation(description: "Returned Text")
        
        let expectedResult: [SelectLanguageViewModel.ItemLabel] = [.language("French")]
        
        viewModel.visibleItems = { item in
            XCTAssertEqual(item, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
   
    func test_GivenViewModel_WhenViewDidLoad_ThenResultVisibleItemsIsCorrectlyReturned() {
        let mockRepository = MockSelectLanguageRepository()
        let delegate = MockSelectLanguageViewControllerDelegate()
        let viewModel = SelectLanguageViewModel(languageType: .result,
                                          repository: mockRepository,
                                          delegate: delegate)
        let expectation = self.expectation(description: "Returned Text")
        
        let expectedResult: [SelectLanguageViewModel.ItemLabel] = [.language("English")]
        
        viewModel.visibleItems = { item in
            XCTAssertEqual(item, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_GivenASelectLanguageViewmodel_WhenViewDidDidSelectitemForRequestThenDelegateIsCoreectlyCalled() {
           let mockRepository = MockSelectLanguageRepository()
           let delegate = MockSelectLanguageViewControllerDelegate()
           let viewModel = SelectLanguageViewModel(languageType: .result,
                                             repository: mockRepository,
                                             delegate: delegate)
        viewModel.viewDidLoad()

        viewModel.didSelectItem(at: 0)
    
        XCTAssertEqual(delegate.language, SelectLanguageType.request("French", "Fr"))

    }
    
}
