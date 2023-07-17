//
//  LocationDetailViewModel.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

import XCTest
@testable import interviewapp

class LocationDetailViewModelTests: XCTestCase {
    
    func testFetchLocationDetail() async {
        let expectation = XCTestExpectation(description: "Fetch Location Detail")
        
        let viewModel = LocationDetailViewModel(id: "1", locationWorker: MockLocationWorker(), characterWorker: MockCharacterWorker())

        viewModel.fetchLocationDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(viewModel.location, "Location should not be nil")
            XCTAssert(!viewModel.characters.isEmpty, "Characters should not be empty")
            XCTAssertEqual(viewModel.screenState, .success, "Screen state should be success")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 10.0)
    }
    
    func testFetchCharactersDetail() async {
        let expectation = XCTestExpectation(description: "Fetch Characters Detail")
        
        let viewModel = LocationDetailViewModel(id: "1", locationWorker: MockLocationWorker(), characterWorker: MockCharacterWorker())
        
        viewModel.fetchCharactersDetail()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssert(!viewModel.characters.isEmpty, "Characters should not be empty")
            XCTAssertEqual(viewModel.screenState, .success, "Screen state should be success")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 10.0)
    }

    func testGetCharactersID() async {
        let locationWorker = MockLocationWorker() // Make sure this mock returns location with residents URLs
        let characterWorker = MockCharacterWorker() // This can be any mock as we won't be using it here
        let viewModel = LocationDetailViewModel(id: "1", locationWorker: locationWorker, characterWorker: characterWorker)

        // Trigger fetching location details
        viewModel.fetchLocationDetail()

        // Allow some time for async operation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let characterIDs = viewModel.getCharactersID()

            // Here you assert that the output is as expected.
            // Make sure you replace [1, 2] with the actual IDs you expect to be extracted from the URLs
            XCTAssertEqual(characterIDs, [1, 2], "Extracted character IDs don't match expected values")
        }
    }

}

