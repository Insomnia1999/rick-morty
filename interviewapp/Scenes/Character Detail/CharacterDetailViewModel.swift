//
//  CharacterDetailViewModel.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI
import Combine

enum CharacterDestination {
    case main
    case locationDetail(id: String)
    case episodeDetail(id: String)
}

class CharacterDetailViewModel: ObservableObject {

    @Published var screenState: ScreenState = .loading
    @Published var character: Character?
    
    var characterWorker: CharacterWorkerProtocol?
    var screen: CharacterDestination?
    var id: String?
    var screenId: String?
    
    let imageSize: CGFloat = 90
    let cornerRadius: CGFloat = 50
    
    init(id: String?, characterWorker: CharacterWorkerProtocol = CharacterWorker(), screen: CharacterDestination) {
        self.id = id
        self.characterWorker = characterWorker
        self.screen = screen
        
        DispatchQueue.main.async {
            self.screenState = .loading
        }
    }

    func fetchCharacterDetail() {
        
        Task(priority: .background) {
            guard let id = id else {
                self.screenState = .error
                return
            }
            
            do {
                let response = try await characterWorker?.detail(id: id)
                
                guard let character = response else {
                    DispatchQueue.main.async {
                        self.screenState = .error
                    }
                    return
                }

                DispatchQueue.main.async {
                    
                    self.character = character
                    self.screenState = .success
                 
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.screenState = .networkError
                }
            }
        }
    }
    
    func popToViewController(appState: AppState) {
        switch screen {
        case .main:
            appState.switchView = .main
        case let .locationDetail(id):
            appState.switchView = .locationDetail(id: id)
        case let .episodeDetail(id):
            appState.switchView = .episodeDetail(id: id)
        default:
            appState.switchView = .main
        }
    }
}
