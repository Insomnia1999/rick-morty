//
//  BaseApiStore.swift
//  busoviedo-swiftui
//
//  Created by Iván Fernández Arenas on 11/4/23.
//

import Alamofire
import Foundation
import ObjectMapper
import PromiseKit

enum ApiException: Error {
    case EmptyResponse
    case ParseError
}

class BaseApiDataSource {
    public func performRequest(route: BaseRouter, decoder _: JSONDecoder = JSONDecoder()) async throws -> String {
        let sessionManager = NetworkManager.unauthorizedSharedManager
        
        let response = try await sessionManager.asyncRequest(route)
            
        guard let data = response.data else { return "" }
            
        return String(data: data, encoding: .utf8) ?? ""

    }
}

class BaseApiStore {
    func parseEntity<T: Mappable>(json: String) throws -> T {
        if json.count == 0 {
            throw ApiException.EmptyResponse
        }

        if let decoded = T(JSONString: json) {
            return decoded
        }
        throw ApiException.ParseError
    }

    func parseEntities<T: Mappable>(json: String) throws -> [T] {
        if let decoded = [T](JSONString: json) {
            return decoded
        }
        throw ApiException.ParseError
    }
}
