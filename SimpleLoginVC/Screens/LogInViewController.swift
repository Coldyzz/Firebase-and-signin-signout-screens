//
//  LogInViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 23.09.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    let authenticationService: AuthenticationService = FirebaseAuthenticationService()
    
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
        
        guard let email = optionalEmail, email.contains("@") else {
            emailField.layer.borderColor = UIColor.red.cgColor
            errorEmailLabel.text = "Email is invalid format"
            errorEmailLabel.isHidden = false
            return
        }
        emailField.layer.borderColor = UIColor.green.cgColor
        errorEmailLabel.isHidden = true
        
        let optionalPassword = passwordField.text
        
        guard let password = optionalPassword, password.count >= 6 else {
            passwordField.layer.borderColor = UIColor.red.cgColor
            errorPasswordLabel.text = "Password must contains six or more  characters"
            errorPasswordLabel.isHidden = false
            return
        }
        passwordField.layer.borderColor = UIColor.green.cgColor
        errorPasswordLabel.isHidden = true
        
        authenticationService.signIn(email: email, password: password)
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

