//
//  LocationViewModel.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI
import Combine

class LocationsViewModel: ObservableObject {

    @Published var screenState: ScreenState = .loading
    @Published var locations: [Location] = [Location]()
    @Published var searchTerm: String = ""
    
    var locationWorker: LocationWorkerProtocol?
    
    var page: Int = 1
    var pageCount: Int = 0
      //private var page = 0
    
    init(locationWorker: LocationWorkerProtocol = LocationWorker()) {
        self.locationWorker = locationWorker
        
        DispatchQueue.main.async {
            self.screenState = .loading
        }
    }
    
    func requestInitialSetOfItems() {
        self.locations = []
        self.page = 1
        
        Task(priority: .background) {
            await fetchLocations(for: searchTerm)
        }
    }
      
    func requestMoreItemsIfNeeded() {
        if page <= pageCount{
              
            Task(priority: .background) {
                await fetchLocations(for: searchTerm)
            }
        }
    }

    func fetchLocations(for searchTerm: String) async {
        
        
        Task(priority: .background) {
            do {
                let response = try await locationWorker?.list(searchTerms: searchTerm, page: page)
                
                guard let info = response?.info, let characters = response?.result else {
                    DispatchQueue.main.async {
                        self.screenState = .error
                    }
                    return
                }
                
                self.pageCount = info.pages ?? 0
                
                DispatchQueue.main.async {
                    if characters.isEmpty && self.locations.isEmpty{
                        self.screenState = .noItems
                        return
                    }
                    
                    self.locations.append(contentsOf: characters)
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
