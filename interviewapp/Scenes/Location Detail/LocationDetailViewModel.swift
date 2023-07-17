//
//  LocationDetailViewModel.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI
import Combine

class LocationDetailViewModel: ObservableObject {

    @Published var screenState: ScreenState = .loading
    @Published var location: Location?
    @Published var characters: [Character] = [Character]()
    
    var locationWorker: LocationWorkerProtocol?
    var characterWorker: CharacterWorkerProtocol?
    var id: String?
    
    let imageSize: CGFloat = 90
    let cornerRadius: CGFloat = 50
    
    init(id: String?, locationWorker: LocationWorkerProtocol = LocationWorker(), characterWorker: CharacterWorkerProtocol = CharacterWorker()) {
        self.id = id
        self.locationWorker = locationWorker
        self.characterWorker = characterWorker
        
        DispatchQueue.main.async {
            self.screenState = .loading
        }
    }

    func fetchLocationDetail() {
        
        Task(priority: .background) {
            guard let id = id else {
                self.screenState = .error
                return
            }
            
            do {
                let response = try await locationWorker?.detail(id: id)
                
                guard let location = response else {
                    DispatchQueue.main.async {
                        self.screenState = .error
                    }
                    return
                }

                DispatchQueue.main.async {
                    
                    self.location = location
                    self.fetchCharactersDetail()
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.screenState = .networkError
                }
            }
        }
    }
    
    func fetchCharactersDetail() {
        
        Task(priority: .background) {
            do {
                let characterIds = getCharactersID()
                let ids = characterIds.map { String($0) }.joined(separator: ",")
                let response = try await characterWorker?.details(ids: ids)
                
                guard let characters = response else {
                    DispatchQueue.main.async {
                        self.screenState = .error
                    }
                    return
                }

                DispatchQueue.main.async {
                    
                    self.characters = characters
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
        appState.switchView = .main
    }
    
    func getCharactersID() -> [Int] {
        
        var charactersIds: [Int] = []
        
        for character in location?.residents ?? [String]() {
            
            let characterSplit = character.split(separator: "/")
            let characterId = (characterSplit.last! as NSString).integerValue
            
            charactersIds.append(characterId)
        }

        return charactersIds
    }
}
