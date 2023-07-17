//
//  ViewManager.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 14/7/23.
//

import SwiftUI

struct ViewManager: View {
    @StateObject var appState = AppState()
    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        Group {
            switch appState.switchView {
            case .main:
                TabBarView()
                    .environmentObject(appState)
                    .transition(transition)
            case let .characterDetail(id, screen):
                CharacterDetailView(viewModel: CharacterDetailViewModel(id: id, screen: screen))
                    .environmentObject(appState)
                    .transition(transition)
            case let .locationDetail(id):
                LocationDetailView(viewModel: LocationDetailViewModel(id: id))
                    .environmentObject(appState)
                    .transition(transition)
            case let .episodeDetail(id):
                EpisodeDetailView(viewModel: EpisodeDetailViewModel(id: id))
                    .environmentObject(appState)
                    .transition(transition)
            }
        }//.animation(.default, value: appState.switchScene)
    }
}
