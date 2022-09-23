//
//  ViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 23.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let whiteView = whiteView
        whiteView!.layer.cornerRadius = 16
        emailField.layer.borderWidth = 0.5
        emailField.layer.cornerRadius = 8
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.cornerRadius = 8
        
    }
    @IBAction func signinClicked(_ sender: Any) {
        
        let optionalEmail = emailField.text
        if let email = optionalEmail {
            if email.contains("@") {
                emailField.layer.borderColor = UIColor.green.cgColor
            } else {
                emailField.layer.borderColor = UIColor.red.cgColor
            }
        } else {
            emailField.layer.borderColor = UIColor.red.cgColor
        }
        
        let optionalPassword = passwordField.text
        if let password = optionalPassword {
            if password.count >= 6 {
                emailField.layer.borderColor = UIColor.green.cgColor
            } else {
                passwordField.layer.borderColor = UIColor.red.cgColor
            }
        } else {
            passwordField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
    }
}

