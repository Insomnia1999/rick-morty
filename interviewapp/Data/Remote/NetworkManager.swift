//
//  NetworkManager.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import Alamofire
import Foundation

extension Session {
    func asyncRequest(_ urlRequest: Alamofire.URLRequestConvertible) async throws -> AFDataResponse<String> {
        
        return try await withCheckedThrowingContinuation { continuation in
            self.request(urlRequest)
                .validate()
                .responseString { response in
                switch response.result {
                case .success:
                    continuation.resume(returning: response)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}

enum NetworkManager {
    static let unauthorizedSharedManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Constants.Network.timeout
        configuration.timeoutIntervalForResource = Constants.Network.timeout
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .returnCacheDataElseLoad

        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })

        var retval = Session(configuration: configuration, interceptor: nil, cachedResponseHandler: responseCacher)

        return retval
    }()
}

protocol ApiCallDelegate {}
