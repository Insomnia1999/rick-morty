//
//  MockEpisodeWorker.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//

@testable import interviewapp

class MockEpisodeWorker: EpisodeWorkerProtocol {
    var mockEpisode: Episode
    var mockEpisodes: [Episode]
    var mockInfo: ServerInformation

    init(mockEpisode: Episode = Episode(),
         mockEpisodes: [Episode] = [Episode()],
         mockInfo: ServerInformation = ServerInformation(count: 1, pages: 1, next: nil, prev: nil)) {
        self.mockEpisode = mockEpisode
        self.mockEpisodes = mockEpisodes
        self.mockInfo = mockInfo
    }
    
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Episode> {
        return ListServerResponse(info: mockInfo, result: mockEpisodes)
    }
    
    func detail(id: String) async throws -> Episode {
        return mockEpisode
    }
    
    func details(ids: String) async throws -> [Episode] {
        return mockEpisodes
    }
}
