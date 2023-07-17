//
//  TabBarView.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var selectedIndex: Tab = Globals.tabState
    
    var body: some View {
        AppTabBar(selectedTab: $selectedIndex) { index in
            switch index {
            case .characters:
                CharactersView()
                    .environmentObject(appState)
            case .episodes:
                CharactersView()
                    .environmentObject(appState)
            case .locations:
                CharactersView()
                    .environmentObject(appState)
            }
        }
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

