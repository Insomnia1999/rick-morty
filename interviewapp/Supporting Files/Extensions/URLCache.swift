//
//  URLCache.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import Foundation

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
