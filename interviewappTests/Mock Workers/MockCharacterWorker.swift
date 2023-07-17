//
//  MockCharacterWorker.swift
//  interviewappTests
//
//  Created by Iván Fernández Arenas on 17/7/23.
//
@testable import interviewapp

class MockCharacterWorker: CharacterWorkerProtocol {
    var mockCharacter: Character
    var mockCharacters: [Character]
    var mockInfo: ServerInformation

    init(mockCharacter: Character = Character(),
         mockCharacters: [Character] = [Character()],
         mockInfo: ServerInformation = ServerInformation(count: 1, pages: 1, next: nil, prev: nil)) {
        self.mockCharacter = mockCharacter
        self.mockCharacters = mockCharacters
        self.mockInfo = mockInfo
    }
    
    func list(searchTerms: String, page: Int) async throws -> ListServerResponse<Character> {
        return ListServerResponse(info: mockInfo, result: mockCharacters)
    }
    
    func detail(id: String) async throws -> Character {
        return mockCharacter
    }
    
    func details(ids: String) async throws -> [Character] {
        return mockCharacters
    }
}

