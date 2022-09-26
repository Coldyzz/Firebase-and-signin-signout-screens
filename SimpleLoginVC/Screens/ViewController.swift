//
//  ViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 23.09.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
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
    fileprivate func signIn() {
        let optionalEmail = emailField.text
        if let email = optionalEmail {
            if email.contains("@") {
                emailField.layer.borderColor = UIColor.green.cgColor
                errorEmailLabel.isHidden = true
            } else {
                emailField.layer.borderColor = UIColor.red.cgColor
                errorEmailLabel.text = "Email is invalid format"
                errorEmailLabel.isHidden = false
            }
        } else {
            emailField.layer.borderColor = UIColor.red.cgColor
        }
        
        let optionalPassword = passwordField.text
        if let password = optionalPassword {
            if password.count >= 6 {
                passwordField.layer.borderColor = UIColor.green.cgColor
                errorPasswordLabel.isHidden = true
            } else {
                passwordField.layer.borderColor = UIColor.red.cgColor
                errorPasswordLabel.text = "Password must contains six or more  characters"
                errorPasswordLabel.isHidden = false
            }
        } else {
            passwordField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @IBAction func signinClicked(_ sender: Any) {
        signIn()
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            signIn()
        }
        return true
    }
}

