//
//  CharactersWorker.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import Foundation

protocol CharacterWorkerProtocol {
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Character>
    func detail(id: String) async throws -> Character
    func details(ids: String) async throws -> [Character]
}

class CharacterWorker: CharacterWorkerProtocol {
   var apiStore: CharacterApiStoreProtocol = CharacterApiStore()
    
    convenience init(apiStore: CharacterApiStoreProtocol) {
        self.init()
        self.apiStore = apiStore
    }
    
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Character> {
        return try await self.apiStore.list(searchTerm: searchTerms, page: page)
    }
    
    func detail(id: String) async throws -> Character {
        return try await self.apiStore.detail(id: id)
    }
    
    func details(ids: String) async throws -> [Character] {
        return try await self.apiStore.details(ids: ids)
    }
}

