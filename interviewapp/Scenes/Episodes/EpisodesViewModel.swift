//
//  EpisodesViewModel.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI
import Combine

class EpisodesViewModel: ObservableObject {

    @Published var screenState: ScreenState = .loading
    @Published var episodes: [Episode] = [Episode]()
    @Published var searchTerm: String = ""
    
    var episodeWorker: EpisodeWorkerProtocol?
    
    var page: Int = 1
    var pageCount: Int = 0
      //private var page = 0
    
    init(episodeWorker: EpisodeWorkerProtocol = EpisodeWorker()) {
        self.episodeWorker = episodeWorker
        
        DispatchQueue.main.async {
            self.screenState = .loading
        }
    }
    
    func requestInitialSetOfItems() {
        self.episodes = []
        self.page = 1
        
        Task(priority: .background) {
            await fetchEpisodes(for: searchTerm)
        }
    }
      
    func requestMoreItemsIfNeeded() {
        if page <= pageCount{
              
            Task(priority: .background) {
                await fetchEpisodes(for: searchTerm)
            }
        }
    }

    func fetchEpisodes(for searchTerm: String) async {
        
        Task(priority: .background) {
            do {
                let response = try await episodeWorker?.list(searchTerms: searchTerm, page: page)
                
                guard let info = response?.info, let characters = response?.result else {
                    DispatchQueue.main.async {
                        self.screenState = .error
                    }
                    return
                }
                
                self.pageCount = info.pages ?? 0
                
                DispatchQueue.main.async {
                    if characters.isEmpty && self.episodes.isEmpty{
                        self.screenState = .noItems
                        return
                    }
                    
                    self.episodes.append(contentsOf: characters)
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
