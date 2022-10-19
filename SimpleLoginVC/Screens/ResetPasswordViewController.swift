//
//  ResetPasswordViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 12.10.2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    let authenticationService: AuthenticationService = FirebaseAuthenticationService()
    lazy var  emailField: UITextField = {
        let field = UITextField(frame: CGRect(x: 16,
                                              y: 100,
                                              width: 200,
                                              height: 48))
        field.placeholder = "Eneter Your Email.."
        field.autocapitalizationType = .none
        field.backgroundColor = .systemBackground
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 0.5
        // field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 8,
                              y: 175,
                              width: 100,
                              height: 48)
        button.setTitle("Reset Password", for: .normal)
        button.addTarget(self, action: #selector(onResetPasswordClicked), for: .touchUpInside)
        return button
    }()
    lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        title = "Reset Password"
        view.addSubview(emailField)
        view.addSubview(resetButton)
        view.addSubview(backgroundContainer)
        backgroundContainer.addSubview(emailField)
        backgroundContainer.addSubview(resetButton)
        backgroundContainer.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                   multiplier: 0.95).isActive = true
        backgroundContainer.heightAnchor.constraint(equalTo: backgroundContainer.widthAnchor).isActive = true
        backgroundContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: backgroundContainer.widthAnchor,
                                          multiplier: 0.9).isActive = true
        emailField.centerXAnchor.constraint(equalTo: backgroundContainer.centerXAnchor).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        emailField.topAnchor.constraint(equalTo: backgroundContainer.topAnchor,
                                        constant: 100).isActive = true
        resetButton.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                         constant: 16).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: emailField.centerXAnchor).isActive = true
        resetButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }
    @objc func onResetPasswordClicked() {
        guard let email = emailField.text else {
            return
        }
        authenticationService.forgotPassword(email: email) { error in
            if let message = error {
                let alert = UIAlertController(title: "",
                                              message: message,
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: UIAlertAction.Style.default))
                self.present(alert, animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
