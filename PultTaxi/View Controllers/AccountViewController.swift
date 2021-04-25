//
//  AccountViewController.swift
//  PultTaxi
//
//  Created by Нариман on 25.04.2021.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = KeychainWrapper.standard.string(forKey: "token") {
            clientService.getInfo(token: token)
        }
        

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
