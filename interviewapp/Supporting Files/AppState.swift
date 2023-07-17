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
        case splash
        case main
        case characterDetail(id: Int)
        case locationsDetail(id: Int)
        case episodesDetail(id: Int)
    }
    
    @Published var switchView = CurrentView.splash
}

