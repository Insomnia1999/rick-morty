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
            case .splash:
                SplashView()
                    .environmentObject(appState)
                    .transition(transition)
            case .main: TabBarView()
                    .environmentObject(appState)
                    .transition(transition)
            case let .characterDetail(id):
                SplashView()
                    .environmentObject(appState)
            case let .episodesDetail(id):
                SplashView()
                    .environmentObject(appState)
            case let .locationsDetail(id):
                SplashView()
                    .environmentObject(appState)
            }
        }//.animation(.default, value: appState.switchScene)
    }
}
