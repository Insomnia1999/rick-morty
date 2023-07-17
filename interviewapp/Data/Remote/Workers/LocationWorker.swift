//
//  LocationWorker.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import Foundation

protocol LocationWorkerProtocol {
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Location>
    func detail(id: String) async throws -> Location
    func details(ids: String) async throws -> [Location]
}

class LocationWorker: LocationWorkerProtocol {
   var apiStore: LocationApiStoreProtocol = LocationApiStore()
    
    convenience init(apiStore: LocationApiStoreProtocol) {
        self.init()
        self.apiStore = apiStore
    }
    
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Location> {
        return try await self.apiStore.list(searchTerm: searchTerms, page: page)
    }
    
    func detail(id: String) async throws ->Location {
        return try await self.apiStore.detail(id: id)
    }
    
    func details(ids: String) async throws -> [Location] {
        return try await self.apiStore.details(ids: ids)
    }
}
