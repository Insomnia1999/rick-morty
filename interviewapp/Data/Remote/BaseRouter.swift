//
//  BaseRouter.swift
//  busoviedo-swiftui
//
//  Created by Iván Fernández Arenas on 11/4/23.
//

import Alamofire
import Foundation

protocol BaseRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }

    var jsonEncoder: JSONEncoder { get }
}

extension BaseRouter {
    var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }
}

extension BaseRouter {
    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try URL(string: "\(Constants.Network.baseURLString.asURL())\(path)", relativeTo: nil)

        var urlRequest = URLRequest(url: url!)

        if method == .get {
            urlRequest = try! URLEncoding(destination: .queryString).encode(urlRequest, with: parameters)
        }

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Parameters
        if let parameters = parameters {
            do {
                if method != .get {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
