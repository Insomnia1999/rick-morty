//
//  Character.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import ObjectMapper

struct Character: Mappable, Equatable, Identifiable {

    enum CharacterGender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown
    }
    
    enum CharacterStatus: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    var id: Int?
    var name: String?
    var status: CharacterStatus?
    var species: String?
    var type: String?
    var gender: CharacterGender?
    var origin, location: CharacterLocation?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
    
    init() {
        
    }
    
    init?(map: ObjectMapper.Map) {
        
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
        species <- map["species"]
        type <- map["type"]
        gender <- map["gender"]
        origin <- map["origin"]
        location <- map["location"]
        image <- map["image"]
        episode <- map["episode"]
        url <- map["url"]
        created <- map["created"]
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.status == rhs.status && lhs.species == rhs.species && lhs.type == rhs.type && lhs.gender == rhs.gender && lhs.origin == rhs.origin && lhs.location == rhs.location && lhs.image == rhs.image && lhs.episode == rhs.episode && lhs.url == rhs.url && lhs.created == rhs.created
    }
}

struct CharacterLocation: Mappable, Equatable {
    var name: String?
    var url: String?
    
    init?(map: ObjectMapper.Map) {
        
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
        url <- map["url"]
    }
    
    static func == (lhs: CharacterLocation, rhs: CharacterLocation) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
