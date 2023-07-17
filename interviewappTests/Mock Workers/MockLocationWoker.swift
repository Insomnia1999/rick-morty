//
//  MockLocationWoker.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

@testable import interviewapp

class MockLocationWorker: LocationWorkerProtocol {
    var mockLocation: Location
    var mockLocations: [Location]
    var mockInfo: ServerInformation

    init(mockLocation: Location = Location(),
         mockLocations: [Location] = [Location()],
         mockInfo: ServerInformation = ServerInformation(count: 1, pages: 1, next: nil, prev: nil)) {
        self.mockLocation = mockLocation
        self.mockLocations = mockLocations
        self.mockInfo = mockInfo
    }
    
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Location> {
        return ListServerResponse(info: mockInfo, result: mockLocations)
    }
    
    func detail(id: String) async throws -> Location {
        return mockLocation
    }
    
    func details(ids: String) async throws -> [Location] {
        return mockLocations
    }
}
