//
//  CharacterDetailViewModelTests.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

import XCTest
@testable import interviewapp

class CharacterDetailViewModelTests: XCTestCase {

    func testFetchCharacterDetail() async {
        let expectation = XCTestExpectation(description: "Fetch Episode Detail")
        
        let viewModel = CharacterDetailViewModel(id: "1", characterWorker: MockCharacterWorker(), screen: .main)

        viewModel.fetchCharacterDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(viewModel.character, "Episode should not be nil")
            XCTAssertEqual(viewModel.screenState, .success, "Screen state should be success")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 10.0)
        
    }
}

