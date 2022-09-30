//
//  EmailTextField.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 30.09.2022.
//

import Foundation
import UIKit

class EmailTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.cornerRadius = 8
    }
    
    
    func validateEmailTextField(errorLabel: UILabel) {
        let optionalEmail = text
        
        guard let email = optionalEmail, email.contains("@") else {
            layer.borderColor = UIColor.red.cgColor
            errorLabel.text = "Email is invalid format"
            errorLabel.isHidden = false
            return
        }
        layer.borderColor = UIColor.green.cgColor
        errorLabel.isHidden = true
    }
}
