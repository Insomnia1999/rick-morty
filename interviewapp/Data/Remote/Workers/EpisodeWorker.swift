//
//  EpisodeWorker.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import Foundation

protocol EpisodeWorkerProtocol {
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Episode>
    func detail(id: String) async throws -> Episode
    func details(ids: String) async throws -> [Episode]
}

class EpisodeWorker: EpisodeWorkerProtocol {
   var apiStore: EpisodeApiStoreProtocol = EpisodeApiStore()
    
    convenience init(apiStore: EpisodeApiStoreProtocol) {
        self.init()
        self.apiStore = apiStore
    }
    
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Episode> {
        return try await self.apiStore.list(searchTerm: searchTerms, page: page)
    }
    
    func detail(id: String) async throws -> Episode {
        return try await self.apiStore.detail(id: id)
    }
    
    func details(ids: String) async throws -> [Episode] {
        return try await self.apiStore.details(ids: ids)
    }
}
