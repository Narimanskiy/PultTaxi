//
//  ViewController.swift
//  PultTaxi
//
//  Created by Нариман on 24.04.2021.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import IQKeyboardManager

class WelcomeViewController: UIViewController, UITextFieldDelegate {

    // TODO - сделать маску к телефонному номеру 916-883-67-90, проще всего либой
    // например https://github.com/artemkrachulov/AKMaskField

    

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)
        ]
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Введите номер вашего телефона", attributes:attributes)

        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Sms Segue" else { return }
        guard let destination = segue.destination as? SMSViewController else { return }
        destination.phoneNumber = phoneTextField.text!
    }

    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        let textField = phoneTextField.text
        if textField == "" {
            let alert = UIAlertController(title: "Введите номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else if textField!.count < 10 {
            let alert = UIAlertController(title: "Некорректный номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        if let phoneNumber = phoneTextField.text {
            if phoneNumber.count == 10 {
                AuthService.shared.sendPhoneNumber(phoneNumber: "7\(phoneNumber)") { result in
                    if result {
                        KeychainWrapper.standard.set(phoneNumber, forKey: "phoneNumber")
                        self.performSegue(withIdentifier: "Sms Segue", sender: nil)
                    } else {
                        let alert = UIAlertController(title: "Ошибка!", message: "Повторите еще раз", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
            }
            
            }
        }
        
    }
    
}

