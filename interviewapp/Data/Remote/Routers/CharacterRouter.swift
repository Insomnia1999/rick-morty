//
//  CharacterRouter.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import Alamofire

enum CharactersRouter: BaseRouter {
    case list(searchTerm: String, page: Int)
    case detail(id: String)
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .list, .detail:
            return .get
        }
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case let .list(searchTerm, page):
            return "character/?page=\(page)&name=\(searchTerm)"
        case let .detail(id):
            return "character/\(id)"
        }
    }
    
    // MARK: - Parameters
    
    var parameters: Parameters? {
        switch self {
        case .list, .detail:
            return nil
        }
    }

}
