//
//  EpisodesViewModel.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

@testable import interviewapp
import XCTest
import Combine

class LocationsViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testFetchLocations() async throws{
        let expectation = XCTestExpectation(description: "Fetch locations")

        let location1 = Location()
        let location2 = Location()

        let locations = [location1, location2]
        let locationWorker = MockLocationWorker(mockLocations: locations)
        let viewModel = LocationsViewModel(locationWorker: locationWorker)

        await viewModel.fetchLocations(for: "Earth")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(!viewModel.locations.isEmpty, "No locations were loaded.")
            expectation.fulfill()
        }
            
        await fulfillment(of: [expectation], timeout: 10.0)
        
    }

    func testRequestMoreItemsIfNeeded() async {
        let worker = MockLocationWorker()
        let viewModel = LocationsViewModel(locationWorker: worker)

        // Initially, our mock worker has only 1 page
        viewModel.pageCount = 1

        // Load initial locations
        await viewModel.requestInitialSetOfItems()

        // Since we have reached the page limit, no more requests should be made.
        let oldCharacterCount = viewModel.locations.count
        await viewModel.requestMoreItemsIfNeeded()

        // Check if no new locations are fetched
        XCTAssert(oldCharacterCount == viewModel.locations.count, "New locations were incorrectly fetched despite reaching the page limit")
    }

    func testRequestInitialSetOfItems() async {
        let location1 = Location()
        let location2 = Location()

        let locations = [location1, location2]
        let worker = MockLocationWorker(mockLocations: locations)
        let viewModel = LocationsViewModel(locationWorker: worker)

        let expectation = XCTestExpectation(description: "Fetching locations")
         DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
             expectation.fulfill()
         }
         
         // Load initial locations
         await viewModel.requestInitialSetOfItems()
         
         // Wait for expectation
         wait(for: [expectation], timeout: 10.0)

        // At this point, we should have some locations
        XCTAssert(!viewModel.locations.isEmpty, "Locations should have been fetched")

        // Now, request initial set of items again. This should clear the locations array and reset the page.
        await viewModel.requestInitialSetOfItems()

        // Check if locations array is cleared
        XCTAssert(viewModel.locations.isEmpty, "Locations array was not cleared")

        // Check if page is reset to 1
        XCTAssert(viewModel.page == 1, "Page was not reset to 1")
    }

}
