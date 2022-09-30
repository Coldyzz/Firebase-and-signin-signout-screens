//
//  PasswordTextField.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 30.09.2022.
//

import Foundation
import UIKit

class PasswordTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.cornerRadius = 8
    }
    
    func validatePasswordTextField(errorLabel: UILabel){
        let optionalPassword = text
        
        guard let password = optionalPassword, password.count >= 6 else {
            layer.borderColor = UIColor.red.cgColor
            errorLabel.text = "Password must contains six or more  characters"
            errorLabel.isHidden = false
            return
        }
        layer.borderColor = UIColor.green.cgColor
        errorLabel.isHidden = true
    }
}
