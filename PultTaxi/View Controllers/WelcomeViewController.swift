//
//  ViewController.swift
//  PultTaxi
//
//  Created by Нариман on 24.04.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

    @IBAction func buttonPressed(_ sender: Any) {
        alertMessage()
    }
    
}

