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
    
    static let shared: AuthService = AuthService()
    func sendPhoneNumber(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        do {
            let parameters = try Credentials(phoneNumber: phoneNumber).convertToAFParameters()
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            super.get("/requestSMSCodeClient", parameters: parameters).responseDecodable(of: Status.self, decoder: decoder) {
                response in
                switch response.result {
                case .success(let value):
                    if value.status == "success" {
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        } catch  {
            print(error)
        }
    }
    func getToken(phoneNumber: String, password: String, completion: @escaping (String) -> Void, errorCompletion: @escaping (String?) -> Void) {
        do {
            let parameters = try Credentials(phoneNumber: phoneNumber, password: password).convertToAFParameters()
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            super.post("/authenticateClients", parameters: parameters).responseDecodable(of: Token.self, decoder: decoder) {
                response in
                switch response.result {
                case .success(let value):
                    completion(value.token)
                case .failure(let error):
                    print(error)
                    if let data = response.data,
                       let errorObject = try? decoder.decode(Error.self, from: data) {
                        errorCompletion(errorObject.error)
                    } else {
                        errorCompletion(nil)
                    }
                }
            }
        } catch  {
            print(error)
        }
    }
}


