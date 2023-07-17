//
//  CharacterViewModelTest.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

@testable import interviewapp
import XCTest
import Combine

class CharactersViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testFetchCharacters() async throws{
        let expectation = XCTestExpectation(description: "Fetch characters")

        let character1 = Character()
        let character2 = Character()
        
        let mockCharacters = [character1, character2]
        let characterWorker = MockCharacterWorker(mockCharacters: mockCharacters)
        let viewModel = CharactersViewModel(characterWorker: characterWorker)

        await viewModel.fetchCharacters(for: "Morty")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(!viewModel.characters.isEmpty, "No characters were loaded.")
            expectation.fulfill()
        }
            
        await fulfillment(of: [expectation], timeout: 10.0)
    }

    func testRequestMoreItemsIfNeeded() async {
        let worker = MockCharacterWorker()
        let viewModel = CharactersViewModel(characterWorker: worker)

        // Initially, our mock worker has only 1 page
        viewModel.pageCount = 1

        // Load initial characters
        await viewModel.requestInitialSetOfItems()

        // Since we have reached the page limit, no more requests should be made.
        let oldCharacterCount = viewModel.characters.count
        await viewModel.requestMoreItemsIfNeeded()

        // Check if no new characters are fetched
        XCTAssert(oldCharacterCount == viewModel.characters.count, "New characters were incorrectly fetched despite reaching the page limit")
    }

    func testRequestInitialSetOfItems() async {
        let character1 = Character()
        let character2 = Character() 

        let mockCharacters = [character1, character2]
        let worker = MockCharacterWorker(mockCharacters: mockCharacters)
        let viewModel = CharactersViewModel(characterWorker: worker)

        let expectation = XCTestExpectation(description: "Fetching locations")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
         
        await viewModel.requestInitialSetOfItems()
         
        await fulfillment(of: [expectation], timeout: 10.0)

        // At this point, we should have some characters
        XCTAssert(!viewModel.characters.isEmpty, "Characters should have been fetched")

        // Now, request initial set of items again. This should clear the characters array and reset the page.
        await viewModel.requestInitialSetOfItems()

        // Check if characters array is cleared
        XCTAssert(viewModel.characters.isEmpty, "Characters array was not cleared")

        // Check if page is reset to 1
        XCTAssert(viewModel.page == 1, "Page was not reset to 1")
    }

}
