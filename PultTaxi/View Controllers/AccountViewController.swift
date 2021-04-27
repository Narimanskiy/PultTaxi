//
//  AccountTableViewController.swift
//  PultTaxi
//
//  Created by Нариман on 25.04.2021.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper



class AccountViewController: UIViewController {
    
    @IBOutlet weak var nameHeader: UILabel!
    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var phoneHeader: UILabel!
    @IBOutlet weak var phoneText: UILabel!
    
    @IBOutlet weak var emailHeader: UILabel!
    @IBOutlet weak var emailText: UILabel!
    
    @IBOutlet weak var cityHeader: UILabel!
    @IBOutlet weak var cityText: UILabel!
    
    @IBOutlet weak var sexHeader: UILabel!
    @IBOutlet weak var sexText: UILabel!
    
    @IBOutlet weak var birthDayHeader: UILabel!
    @IBOutlet weak var birthDayText: UILabel!
    
    @IBOutlet weak var statusHeader: UILabel!
    @IBOutlet weak var statusText: UILabel!
    
    @IBOutlet weak var ratingHeader: UILabel!
    @IBOutlet weak var ratingText: UILabel!
    
    @IBOutlet weak var iDHeader: UILabel!
    @IBOutlet weak var iDText: UILabel!
    
    @IBOutlet weak var orderHeader: UILabel!
    @IBOutlet weak var orderText: UILabel!
    
    @IBOutlet weak var organizationIdHeader: UILabel!
    @IBOutlet weak var organizationIdText: UILabel!
    
    @IBOutlet weak var registrationHeader: UILabel!
    @IBOutlet weak var registrationText: UILabel!
    
    var infoAll: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = KeychainWrapper.standard.string(forKey: "token") {
            ClientService.shared.getInfo(token: token) {
                
                userInfo in
                self.infoAll = userInfo
                
                self.nameText.text = userInfo.name
                self.phoneText.text = userInfo.phoneNumber
                self.emailText.text = userInfo.email
                self.cityText.text = userInfo.city
                if let sex = userInfo.sex {
                    self.sexText.text = sex
                    self.sexHeader.isHidden = false
                    self.sexText.isHidden = false
                } else {
                    self.sexHeader.isHidden = true
                    self.sexText.isHidden = true
                }
                
                if let birthDay = userInfo.birthDay {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy"
                    self.birthDayText.text = formatter.string(from: birthDay)
                    self.birthDayHeader.isHidden = false
                    self.birthDayText.isHidden = false
                } else {
                    self.birthDayHeader.isHidden = true
                    self.birthDayText.isHidden = true
                }
                
                self.statusText.text = String(userInfo.status)
                self.ratingText.text = userInfo.rating
                self.iDText.text = String(userInfo.id)
                if let activeOrder = userInfo.activeOrder {
                    self.orderText.text = String(activeOrder)
                    self.orderHeader.isHidden = false
                    self.orderText.isHidden = false
                } else {
                    self.orderHeader.isHidden = true
                    self.orderText.isHidden = true
                }
                if let organizationId = userInfo.organizationID {
                    self.organizationIdText.text = String(organizationId)
                    self.organizationIdHeader.isHidden = false
                    self.organizationIdText.isHidden = false
                } else {
                    self.organizationIdHeader.isHidden = true
                    self.organizationIdText.isHidden = true
                }
                
                self.registrationText.text = userInfo.needRegistration ? "Нужна" : "Не нужна"
            }
        }
    }
}
