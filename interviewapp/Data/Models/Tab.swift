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
            return "person.3.fill"
        case .locations:
            return "map.fill"
        case .episodes:
            return "tv.fill"
        }
    }
    
    var title: String {
        switch self {
        case .characters:
            return "Characters"
        case .locations:
            return "Locations"
        case .episodes:
            return "Episodes"
        }
    }
    
    var color: Color {
        switch self {
        case .characters, .locations, .episodes:
            return .tabColor
        }
    }
}
