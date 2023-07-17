//
//  Tab.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case characters, locations, episodes
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .characters:
            return "MapImage"
        case .locations:
            return "FavsImage"
        case .episodes:
            return "LinesImage"
        }
    }
    
    var title: String {
        switch self {
        case .characters:
            return "Personajes"
        case .locations:
            return "Localizaciones"
        case .episodes:
            return "Episodios"
        }
    }
    
    var color: Color {
        switch self {
        case .characters, .locations, .episodes:
            return .tabColor
        }
    }
}
