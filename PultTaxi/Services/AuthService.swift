//
//  AuthService.swift
//  Taxity
//
//  Created by Нариман on 25.04.2021.
//

import Foundation
import Alamofire

struct Credentials: Codable {
    var phoneNumber: String
    var password: String?
}

class AuthService: HttpService {
    init() {
        super.init(url: "\(AppConfig.baseUrl)")
    }
    func sendPhoneNumber(phoneNumber: String) {
        do {
            let parameters = try Credentials(phoneNumber: phoneNumber).convertToAFParameters()
            super.get("/requestSMSCodeClient", parameters: parameters).responseJSON {
                response in
            }
        } catch  {
            print(error)
        }
    }
    func getToken(phoneNumber: String, password: String, completion: @escaping (String) -> Void) {
        do {
            let parameters = try Credentials(phoneNumber: phoneNumber, password: password).convertToAFParameters()
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            super.post("/authenticateClients", parameters: parameters).responseDecodable(of: Token.self, decoder: decoder) {
                response in
                
                switch response.result {
                case .success(let value):
                    completion(value.token!)
                    
                case .failure(let error):
                    print(error)
                    
                }
                
            }
        } catch  {
            print(error)
        }
    }
}

let authService = AuthService()
