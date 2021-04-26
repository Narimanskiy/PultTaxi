//
//  BaseService.swift
//  Taxity
//
//  Created by Нариман on 23.04.2021.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper



class HttpService {
    
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    private func sendPost(_ endpoint: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        let req = AF.request(self.url + endpoint, method: .post, parameters: parameters, encoding: encoding, headers: headers)
        return req
    }
    
    private func sendGet(_ endpoint: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
        let req = AF.request(self.url + endpoint, method: .get, parameters: parameters, encoding: encoding, headers: headers)
        return req
    }
}

extension HttpService {
    
    // POST
    public func post(_ endpoint: String, parameters: Parameters?) -> DataRequest {
        return self.sendPost(endpoint, parameters: parameters)
    }
    // GET
    public func get(_ endpoint: String, parameters: Parameters?) -> DataRequest {
            return self.sendGet(endpoint, parameters: parameters)
        }
}




extension Encodable {
  func convertToAFParameters() throws -> [String: Any] {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    let data = try encoder.encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

extension KeychainWrapper.Key {
    static let token: KeychainWrapper.Key = "token"
}



