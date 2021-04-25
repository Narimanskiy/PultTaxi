//
//  Structs.swift
//  PultTaxi
//
//  Created by Нариман on 25.04.2021.
//

import Foundation

struct Token: Codable {
    var token: String?
}

struct UserInfo: Codable {
    let status, id: Int
    let phoneNumber, name, email: String
    let sex: String?
    let birthDay: Date?
    let city, rating: String
    let activeOrder, organizationID: Int?
    let needRegistration: Bool
    
}
