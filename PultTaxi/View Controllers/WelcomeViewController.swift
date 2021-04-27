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

class WelcomeViewController: UIViewController {
    
    private let maxNumberCount = 10
    private let regex = try! NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive)
    
    
    
    
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
        destination.phoneNumber = "7\(getCleanPhoneNumber(phoneNumber: phoneTextField.text!))"
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    
    private func getCleanPhoneNumber(phoneNumber: String) -> String {
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        return regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
    }
    
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        
        
        
        var number = getCleanPhoneNumber(phoneNumber: phoneNumber)
        
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count > 0 && number.count < 4 {
            let pattern = "(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "($1)", options: .regularExpression, range: regRange)
        } else if number.count > 3 && number.count < 7 {
            let pattern = "(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "($1) $2", options: .regularExpression, range: regRange)
        } else if number.count > 6 && number.count < 9 {
            let pattern = "(\\d{3})(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "($1) $2-$3", options: .regularExpression, range: regRange)
        } else if number.count >= 9 && number.count < 11 {
            let pattern = "(\\d{3})(\\d{3})(\\d{2})(\\d{2})"
            number = number.replacingOccurrences(of: pattern, with: "($1) $2-$3-$4", options: .regularExpression, range: regRange)
        }
        return number
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let phoneNumber = getCleanPhoneNumber(phoneNumber: phoneTextField.text ?? "")
        if phoneNumber == "" {
            let alert = UIAlertController(title: "Введите номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else if phoneNumber.count < 10 {
            let alert = UIAlertController(title: "Некорректный номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else if phoneNumber.count == 10 {
            AuthService.shared.sendPhoneNumber(phoneNumber: "7\(phoneNumber)") { result in
                if result {
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

extension WelcomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
}
