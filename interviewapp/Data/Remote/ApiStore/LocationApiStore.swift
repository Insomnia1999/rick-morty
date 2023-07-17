//
//  LocationApiStore.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import Foundation
import ObjectMapper

protocol LocationApiStoreProtocol {
    func list(searchTerm: String, page: Int) async throws -> ListServerResponse<Location>
    func detail(id: String) async throws -> Location
    func details(ids: String) async throws -> [Location]
}

protocol LocationDataSourceProtocol {
    func list(searchTerm: String, page: Int) async throws -> String
    func detail(id: String) async throws -> String
}

class LocationApiStore: BaseApiStore, LocationApiStoreProtocol {
    
    var dataSource: LocationDataSourceProtocol = LocationApiDataSource()

    convenience init(dataSource: LocationDataSourceProtocol) {
        self.init()
        self.dataSource = dataSource
    }
    
    func list(searchTerm: String, page: Int) async throws -> ListServerResponse<Location> {
        let locations = try await self.dataSource.list(searchTerm: searchTerm, page: page)
        return try self.parseEntity(json: locations)
    }
    
    func detail(id: String) async throws -> Location {
        let location = try await self.dataSource.detail(id: id)
        return try self.parseEntity(json: location)
    }
    
    func details(ids: String) async throws -> [Location] {
        let locations = try await self.dataSource.detail(id: ids)
        return try self.parseEntities(json: locations)
    }
    
}

class LocationApiDataSource: BaseApiDataSource, LocationDataSourceProtocol {
    func list(searchTerm: String, page: Int) async throws -> String {
        return try await performRequest(route: LocationRouter.list(searchTerm: searchTerm, page: page))
    }
    
    func detail(id: String) async throws -> String {
        return try await performRequest(route: LocationRouter.detail(id: id))
    }
}
