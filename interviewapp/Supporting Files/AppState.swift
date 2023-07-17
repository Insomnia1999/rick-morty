//
//  AppState.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 14/7/23.
//

import Combine
import SwiftUI

class AppState: ObservableObject {
    enum CurrentView {
        case main
        case characterDetail(id: String, screen: CharacterDestination)
        case locationDetail(id: String)
        case episodeDetail(id: String)
    }
    
    @Published var switchView = CurrentView.main
}

