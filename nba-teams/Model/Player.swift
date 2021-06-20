//
//  Player.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import Foundation

// MARK: - Players
struct Players: Codable {
    var data: [DatumPlayer]
    var meta: Meta
}

// MARK: - Datum
struct DatumPlayer: Codable {
    let id: Int
    let firstName: String
    let heightFeet, heightInches: Int?
    let lastName: String
    let position: Position
    let team: Team
    let weightPounds: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case lastName = "last_name"
        case position, team
        case weightPounds = "weight_pounds"
    }
}

enum Position: String, Codable {
    case c = "C"
    case cF = "C-F"
    case empty = ""
    case f = "F"
    case fC = "F-C"
    case g = "G"
    case gF = "G-F"
    case fG = "F-G"
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let abbreviation, city: String
    let conference: Conference
    let division: Division
    let fullName, name: String

    enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, conference, division
        case fullName = "full_name"
        case name
    }
}

enum Division: String, Codable {
    case atlantic = "Atlantic"
    case central = "Central"
    case northwest = "Northwest"
    case pacific = "Pacific"
    case southeast = "Southeast"
    case southwest = "Southwest"
}

