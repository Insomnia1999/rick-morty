//
//  CharacterApiStore.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import Foundation
import ObjectMapper

protocol CharacterApiStoreProtocol {
    func list(searchTerm: String, page: Int) async throws -> ListServerResponse<Character>
    func detail(id: String) async throws -> Character
    func details(ids: String) async throws -> [Character]
}

protocol CharacterDataSourceProtocol {
    func list(searchTerm: String, page: Int) async throws -> String
    func detail(id: String) async throws -> String
}

class CharacterApiStore: BaseApiStore, CharacterApiStoreProtocol {
    
    var dataSource: CharacterDataSourceProtocol = CharacterApiDataSource()

    convenience init(dataSource: CharacterDataSourceProtocol) {
        self.init()
        self.dataSource = dataSource
    }
    
    func list(searchTerm: String, page: Int) async throws -> ListServerResponse<Character> {
        let characters = try await self.dataSource.list(searchTerm: searchTerm, page: page)
        return try self.parseEntity(json: characters)
    }
    
    func detail(id: String) async throws -> Character {
        let character = try await self.dataSource.detail(id: id)
        return try self.parseEntity(json: character)
    }
    
    func details(ids: String) async throws -> [Character] {
        let characters = try await self.dataSource.detail(id: ids)
        return try self.parseEntities(json: characters)
    }
    
}

class CharacterApiDataSource: BaseApiDataSource, CharacterDataSourceProtocol {
    func list(searchTerm: String, page: Int) async throws -> String {
        return try await performRequest(route: CharactersRouter.list(searchTerm: searchTerm, page: page))
    }
    
    func detail(id: String) async throws -> String {
        return try await performRequest(route: CharactersRouter.detail(id: id))
    }
}
