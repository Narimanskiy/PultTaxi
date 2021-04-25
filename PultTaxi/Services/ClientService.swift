//
//  ClientService.swift
//  PultTaxi
//
//  Created by Нариман on 25.04.2021.
//

import Foundation



class ClientService: HttpService {
    init() {
        super.init(url: "\(AppConfig.baseUrl)/client")
    }
    func getInfo(token: String) {
        do {
            let parameters = try Token(token: token).convertToAFParameters()
            super.get("/getInfo", parameters: parameters).responseJSON {
                response in
            }
        } catch  {
            print(error)
        }
    }
}

let clientService = ClientService()
