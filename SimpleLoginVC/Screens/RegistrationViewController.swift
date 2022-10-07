//
//  RegistrationViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 27.09.2022.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
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
    func signUp() {
        guard let email = emailField.validateEmailTextField(errorLabel: errorEmailLabel) else {
            return
        }
        guard let password = passwordField.validatePasswordTextField(errorLabel: errorPasswordLabel) else {
            return
        }
        authenticationService.signUp(email: email, password: password) { errorMessage in
            if let message = errorMessage {
                let alert = UIAlertController(title: "",
                                              message: message,
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: UIAlertAction.Style.default))
                self.present(alert, animated: true)
            } else {
                guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                        as? HomeViewController else {
                    return
                }
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        signUp()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            signUp()
        }
        return true
    }
}
