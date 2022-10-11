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
        guard let email = emailField.validateEmailTextField(errorLabel: errorEmailLabel) else {
            return
        }
        guard let password = passwordField.validatePasswordTextField(errorLabel: errorPasswordLabel) else {
            return
        }
        authenticationService.signIn(email: email, password: password) { errorMessage in
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
    @IBAction func signinClicked(_ sender: Any) {
        signIn()
    }
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        guard let email = emailField.text else {
            return
        }
        authenticationService.forgotPassword(email: email) { error in
        //показать алерт с ошибкой, если нет ошибки вернуться на предыдущий экран
        }
    }
    @IBAction func createNewAccountClicked(_ sender: Any) {
        guard let viewCon = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController")
                as? RegistrationViewController else {
            return
        }
        navigationController?.pushViewController(viewCon, animated: true)
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
