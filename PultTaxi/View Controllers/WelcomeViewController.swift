//
//  ViewController.swift
//  PultTaxi
//
//  Created by Нариман on 24.04.2021.
//

import UIKit
import Alamofire

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self
        //Looks for single or multiple taps.
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

           //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
           //tap.cancelsTouchesInView = false

           view.addGestureRecognizer(tap)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "Sms Segue" else { return }
            guard let destination = segue.destination as? SMSViewController else { return }
        destination.phoneNumber = phoneTextField.text!
        }

       
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    func alertMessage() {
        if (phoneTextField.text == "") {
            let alert = UIAlertController(title: "Введите номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        } else if phoneTextField.text!.count < 10 {
            let alert = UIAlertController(title: "Некорректный номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
    }
    }
    
    private func textFieldShouldEndEditing(textField: UITextField!) -> Bool {
        let textField = phoneTextField.text
        if textField == "" {
            let alert = UIAlertController(title: "Введите номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            present(alert, animated: true)
            return true
        } else if textField!.count < 10 {
            let alert = UIAlertController(title: "Некорректный номер телефона!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            present(alert, animated: true)
            return true
        }
        return false
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
        if phoneTextField.text?.count == 10 {
//            let url = "https://dev.pulttaxi.ru/api/requestSMSCodeClient?"
//            let parameter = ["phone_number": phoneTextField.text]
//            AF.request(url, method: .get, parameters: parameter).responseJSON { response in
//                print(response)
//            }
            authService.sendPhoneNumber(phoneNumber: phoneTextField.text!)
            
            performSegue(withIdentifier: "Sms Segue", sender: nil)
        }
        
    }
    
}

