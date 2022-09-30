//
//  LogInViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 23.09.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var emailField: EmailTextField!
    @IBOutlet weak var passwordField: PasswordTextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    let authenticationService: AuthenticationService = FirebaseAuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteView.layer.cornerRadius = 16
        emailField.delegate = self
        passwordField.delegate = self
        
    }
    func signIn() {
        
        emailField.validateEmailTextField(errorLabel: errorEmailLabel)
        
        passwordField.validatePasswordTextField(errorLabel: errorPasswordLabel)
        
        authenticationService.signIn(email: emailField.text!, password: passwordField.text!)
    }
    
    @IBAction func signinClicked(_ sender: Any) {
        signIn()
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
    }
    
    @IBAction func createNewAccountClicked(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(controller, animated: true)
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

// разделить на вью поля ввода сразу со всеми настройками
