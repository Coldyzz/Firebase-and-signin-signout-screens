//
//  RegistrationViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 27.09.2022.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        whiteView.layer.cornerRadius = 16
        emailField.layer.borderWidth = 0.5
        emailField.layer.cornerRadius = 8
        emailField.delegate = self
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.cornerRadius = 8
        passwordField.delegate = self
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
    }
}


