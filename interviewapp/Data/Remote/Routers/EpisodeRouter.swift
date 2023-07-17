//
//  EpisodeRouter.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import Alamofire

enum EpisodeRouter: BaseRouter {
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
            return "episode/?page=\(page)&name=\(searchTerm)"
        case let .detail(id):
            return "episode/\(id)"
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
