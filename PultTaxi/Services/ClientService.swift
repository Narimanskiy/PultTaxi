//
//  ClientService.swift
//  PultTaxi
//
//  Created by Нариман on 25.04.2021.
//

import Foundation
import Alamofire

class ClientService: HttpService {
    init() {
        super.init(url: "\(AppConfig.baseUrl)/client")
    }
    
    static let shared: ClientService = ClientService()
    
    func getInfo(token: String, completion: @escaping (UserInfo) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let parameters = try Token(token: token).convertToAFParameters()
            super.get("/getInfo", parameters: parameters).responseDecodable(of: UserInfo.self, decoder: decoder) {
                response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print(error)
                }
            }
        } catch  {
            print(error)
        }
    }
}
