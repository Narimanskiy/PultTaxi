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
    var phoneNumber = KeychainWrapper.standard.string(forKey: "phoneNumber")
    

    /*
    var seconds = 15

    let timer = Timer(...) {
        seconds = seconds - 1
        label.text = "Повторно через \(seconds)"
        if seconds == 0 {
            retryButton.isHidden = false
        }
    }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        
        tf1.becomeFirstResponder()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    
    func rectangleEnable(textField: UITextField) {
        textField.background = UIImage(named: "Rectangle Enable")
    }
    
    func rectangleDisable(textField: UITextField) {
        textField.background = UIImage(named: "Rectangle Disable")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text!.count < 1) && (string.count > 0) {
            if textField == tf1 {
                rectangleEnable(textField: textField)
                tf2.becomeFirstResponder()
            }
            
            if textField == tf2 {
                rectangleEnable(textField: textField)
                tf3.becomeFirstResponder()
            }
            
            if textField == tf3 {
                rectangleEnable(textField: textField)
                tf4.becomeFirstResponder()
            }
            
            if textField == tf4 {
                rectangleEnable(textField: textField)
                tf4.resignFirstResponder()
            }
            textField.text = string
            return false
        } else if (textField.text!.count >= 1) && (string.count == 0) {
            if textField == tf2 {
                rectangleDisable(textField: textField)
                tf1.becomeFirstResponder()
            }
            
            if textField == tf3 {
                rectangleDisable(textField: textField)
                tf2.becomeFirstResponder()
            }
            
            if textField == tf4 {
                rectangleDisable(textField: textField)
                tf3.becomeFirstResponder()
            }

            if textField == tf1 {
                rectangleDisable(textField: textField)
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
        
        let smsCode = tf1.text! + tf2.text! + tf3.text! + tf4.text!

        if smsCode == "9999" {
            AuthService.shared.getToken(phoneNumber: phoneNumber!, password: smsCode, completion: {token in
                KeychainWrapper.standard.set(token, forKey: "token")
                self.performSegue(withIdentifier: "Info Segue", sender: nil)
            }, errorCompletion: { errorCodeOption in
                var errorText = "Произошла неизвестная ошибка, повторите еще раз"
                if let errorCode = errorCodeOption {
                    errorText = "Произошла ошибка: \(errorCode) повторите еще раз"
                }
                let alert = UIAlertController(title: "Ошибка!", message: errorText, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            })
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
