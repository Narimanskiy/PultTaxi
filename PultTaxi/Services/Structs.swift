//
//  Structs.swift
//  PultTaxi
//
//  Created by Нариман on 25.04.2021.
//

import Foundation

struct Token: Codable {
    
    var token: String
}

struct Error: Codable {
    var error: String
}

struct Status: Codable {
    var status: String
}

struct UserInfo: Codable {
    
    let status, id: Int
    let phoneNumber, name, email: String
    let sex: String?
    let birthDay: Date?
    let city, rating: String
    let activeOrder: Int?
    let organizationID: Int?
    let needRegistration: Bool
    
    enum CodingKeys: String, CodingKey {
        case status, id
        case phoneNumber, name, email
        case sex
        case birthDay
        case city, rating
        case activeOrder, organizationID
        case needRegistration
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Int.self, forKey: .status)
        id = try values.decode(Int.self, forKey: .id)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        sex = try? values.decode(String.self, forKey: .sex)
        birthDay = try? values.decode(Date.self, forKey: .birthDay)
        city = try values.decode(String.self, forKey: .city)
        rating = try values.decode(String.self, forKey: .rating)
        activeOrder = try? values.decode(Int.self, forKey: .activeOrder)
        organizationID = try? values.decode(Int.self, forKey: .organizationID)
        needRegistration = try values.decode(Bool.self, forKey: .needRegistration)
    }
    
}
