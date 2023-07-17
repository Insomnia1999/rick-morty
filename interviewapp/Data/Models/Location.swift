//
//  Location.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import ObjectMapper

class Location: Mappable {
    var id: Int?
    var name: String?
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String?
    var created: Date?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        dimension <- map ["dimension"]
        residents <- map ["residents"]
        url <- map["url"]
        created <- (map["created"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssxxx"))
    }
}


