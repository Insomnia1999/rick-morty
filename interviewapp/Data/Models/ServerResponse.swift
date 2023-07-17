//
//  ServerResponse.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import ObjectMapper

class ListServerResponse<T: Mappable>: Mappable {
    
    var info: ServerInformation?
    var result: [T]?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        info <- map["info"]
        result <- map["result"]
    }
}

class ServerInformation: Mappable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        pages <- map["pages"]
        next <- map ["next"]
        prev <- map["prev"]
    }
}
