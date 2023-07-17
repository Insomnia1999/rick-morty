//
//  EpisodesViewModel.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

@testable import interviewapp
import XCTest
import Combine

class EpisodesViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testFetchEpisodes() async throws{
        let expectation = XCTestExpectation(description: "Fetch episodes")

        let episode1 = Episode()
        let episode2 = Episode()

        let episodes = [episode1, episode2]
        let episodesWorker = MockEpisodeWorker(mockEpisodes: episodes)
        let viewModel = EpisodesViewModel(episodeWorker: episodesWorker)

        await viewModel.fetchEpisodes(for: "")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(!viewModel.episodes.isEmpty, "No episodes were loaded.")
            expectation.fulfill()
        }
            
            
        await fulfillment(of: [expectation], timeout: 10.0)
        
    }

    func testRequestMoreItemsIfNeeded() async {
        let worker = MockEpisodeWorker()
        let viewModel = EpisodesViewModel(episodeWorker: worker)

        viewModel.pageCount = 1

        await viewModel.requestInitialSetOfItems()

        let oldCharacterCount = viewModel.episodes.count
        await viewModel.requestMoreItemsIfNeeded()

        XCTAssert(oldCharacterCount == viewModel.episodes.count, "New episodes were incorrectly fetched despite reaching the page limit")
    }

    func testRequestInitialSetOfItems() async {
        let episode1 = Episode()
        let episode2 = Episode()

        let episodes = [episode1, episode2]
        let worker = MockEpisodeWorker(mockEpisodes: episodes)
        let viewModel = EpisodesViewModel(episodeWorker: worker)

        let expectation = XCTestExpectation(description: "Fetching locations")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
         
        await viewModel.requestInitialSetOfItems()
         
        wait(for: [expectation], timeout: 10.0)

        XCTAssert(!viewModel.episodes.isEmpty, "Episodes should have been fetched")

        await viewModel.requestInitialSetOfItems()

        XCTAssert(viewModel.episodes.isEmpty, "Episodes array was not cleared")

        XCTAssert(viewModel.page == 1, "Page was not reset to 1")
    }

}

