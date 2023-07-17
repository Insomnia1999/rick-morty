//
//  EpisodeApiStore.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import Foundation
import ObjectMapper

protocol EpisodeApiStoreProtocol {
    func list(searchTerm: String, page: Int) async throws -> ListServerResponse<Episode>
    func detail(id: String) async throws -> Episode
    func details(ids: String) async throws -> [Episode]
}

protocol EpisodeDataSourceProtocol {
    func list(searchTerm: String, page: Int) async throws -> String
    func detail(id: String) async throws -> String
}

class EpisodeApiStore: BaseApiStore, EpisodeApiStoreProtocol {
    
    var dataSource: EpisodeDataSourceProtocol = EpisodeApiDataSource()

    convenience init(dataSource: EpisodeDataSourceProtocol) {
        self.init()
        self.dataSource = dataSource
    }
    
    func list(searchTerm: String, page: Int) async throws -> ListServerResponse<Episode> {
        let locations = try await self.dataSource.list(searchTerm: searchTerm, page: page)
        return try self.parseEntity(json: locations)
    }
    
    func detail(id: String) async throws -> Episode {
        let location = try await self.dataSource.detail(id: id)
        return try self.parseEntity(json: location)
    }
    
    func details(ids: String) async throws -> [Episode] {
        let locations = try await self.dataSource.detail(id: ids)
        return try self.parseEntities(json: locations)
    }
    
}

class EpisodeApiDataSource: BaseApiDataSource, EpisodeDataSourceProtocol {
    func list(searchTerm: String, page: Int) async throws -> String {
        return try await performRequest(route: EpisodeRouter.list(searchTerm: searchTerm, page: page))
    }
    
    func detail(id: String) async throws -> String {
        return try await performRequest(route: EpisodeRouter.detail(id: id))
    }
}
