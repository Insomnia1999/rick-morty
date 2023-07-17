//
//  Episode.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import ObjectMapper

class Episode: Mappable {
    var id: Int?
    var name: String?
    var airDate: String?
    var episode: String?
    var characters: [String]?
    var url: String?
    var created: Date?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        airDate <- map["air_date"]
        episode <- map["episode"]
        characters <- map["characters"]
        url <- map["url"]
        created <- (map["created"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssxxx"))
    }
}
