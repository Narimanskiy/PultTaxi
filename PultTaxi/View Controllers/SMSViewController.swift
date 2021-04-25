//
//  SMSViewController.swift
//  PultTaxi
//
//  Created by Нариман on 24.04.2021.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class SMSViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    @IBOutlet weak var button: UIButton!
    var phoneNumber = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        
        tf1.becomeFirstResponder()
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text!.count < 1) && (string.count > 0) {
            if textField == tf1 {
                textField.background = UIImage(named: "Rectangle Enable")
                tf2.becomeFirstResponder()
            }
            
            if textField == tf2 {
                textField.background = UIImage(named: "Rectangle Enable")
                tf3.becomeFirstResponder()
            }
            
            if textField == tf3 {
                textField.background = UIImage(named: "Rectangle Enable")
                tf4.becomeFirstResponder()
            }
            
            if textField == tf4 {
                textField.background = UIImage(named: "Rectangle Enable")
                tf4.resignFirstResponder()
            }
            textField.text = string
            return false
        } else if (textField.text!.count >= 1) && (string.count == 0) {
            if textField == tf2 {
                textField.background = UIImage(named: "Rectangle Disable")
                tf1.becomeFirstResponder()
            }
            
            if textField == tf3 {
                textField.background = UIImage(named: "Rectangle Disable")
                tf2.becomeFirstResponder()
            }
            
            if textField == tf4 {
                textField.background = UIImage(named: "Rectangle Disable")
                tf3.becomeFirstResponder()
            }
            
            if textField == tf1 {
                textField.background = UIImage(named: "Rectangle Disable")
                tf1.resignFirstResponder()
            }
            textField.text = ""
            return false
        } else if (textField.text!.count) >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }

    @IBAction func buttonPressed(_ sender: Any) {
        getToken()
        
        }

    
    
    func getToken() {
        let smsCode: String = tf1.text! + tf2.text! + tf3.text! + tf4.text!
        if smsCode == "9999" {
            authService.getToken(phoneNumber: phoneNumber, password: smsCode) { (token) in
                KeychainWrapper.standard.set(token, forKey: "token")
                self.performSegue(withIdentifier: "Info Segue", sender: nil)
            }
        } else if smsCode.count >= 1 && smsCode.count < 4 {
            let alert = UIAlertController(title: "Некорректный СМС!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Упс!", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        } else if smsCode == "" {
            let alert = UIAlertController(title: "Введите СМС!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена!", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        } else if smsCode.count == 4 && smsCode != "9999" {
            let alert = UIAlertController(title: "Неправильный СМС!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Вспоминаю!", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        
    }
    
}
