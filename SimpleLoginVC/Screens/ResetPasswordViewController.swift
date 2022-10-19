//
//  ResetPasswordViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 12.10.2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    let authenticationService: AuthenticationService = FirebaseAuthenticationService()
    lazy var  titleField: UITextField = {
        let field = UITextField(frame: CGRect(x: 16,
                                              y: 100,
                                              width: 200,
                                              height: 48))
        field.placeholder = "Eneter Your Email.."
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Reset Password"
        view.addSubview(titleField)
        let createButton = UIButton(type: .system)
        createButton.frame = CGRect(x: 8,
                                    y: 175,
                                    width: 100,
                                    height: 48)
        createButton.setTitle("Reset Password", for: .normal)
        createButton.addTarget(self, action: #selector(onResetPasswordClicked), for: .touchUpInside)
        view.addSubview(createButton)
    }
    @objc func onResetPasswordClicked() {
        guard let email = titleField.text else {
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
