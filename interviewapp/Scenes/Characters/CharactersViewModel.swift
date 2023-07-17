//
//  CharactersViewModel.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI
import Combine

class CharactersViewModel: ObservableObject {

    @Published var screenState: ScreenState = .loading
    @Published var characters: [Character] = [Character]()
    @Published var searchTerm: String = ""
    
    var characterWorker: CharacterWorkerProtocol?
    
    var page: Int = 1
    var pageCount: Int = 0
      //private var page = 0
    
    init(characterWorker: CharacterWorkerProtocol) {
        self.characterWorker = characterWorker
        
        DispatchQueue.main.async {
            self.screenState = .loading
        }
    }
    
    func requestInitialSetOfItems() {
        self.characters = []
        self.page = 1
        
        Task(priority: .background) {
            await fetchCharacters(for: searchTerm)
        }
    }
      
    func requestMoreItemsIfNeeded() {
        if page <= pageCount{
              
            Task(priority: .background) {
                await fetchCharacters(for: searchTerm)
            }
        }
    }

    func fetchCharacters(for searchTerm: String) async {
        
        Task(priority: .background) {
            do {
                let response = try await characterWorker?.list(searchTerms: searchTerm, page: page)
                
                guard let info = response?.info, let characters = response?.result else {
                    DispatchQueue.main.async {
                        self.screenState = .error
                    }
                    return
                }
                
                self.pageCount = info.pages ?? 0

                DispatchQueue.main.async {
                    if characters.isEmpty && self.characters.isEmpty{
                        self.screenState = .noItems
                        return
                    }
                    
                    self.characters.append(contentsOf: characters)
                    self.page += 1
                    self.screenState = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.screenState = .networkError
                }
            }
        }
    }

}
