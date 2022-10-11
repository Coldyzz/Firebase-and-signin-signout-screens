//
//  NewPostViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 11.10.2022.
//

import UIKit

class NewPostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create New Post"
        let titleField = UITextField(frame: CGRect(x: 16,
                                                   y: 100,
                                                   width: 200,
                                                   height: 48))
        titleField.placeholder = "Please Type Title..."
        titleField.backgroundColor = .secondarySystemBackground
        titleField.layer.cornerRadius = 8.0
        titleField.layer.borderWidth = 1.0
        titleField.layer.borderColor = UIColor.secondaryLabel.cgColor
        view.addSubview(titleField)
        let bodyField = UITextField(frame: CGRect(x: 16,
                                                  y: 150,
                                                  width: 200,
                                                  height: 48))
        bodyField.placeholder = "Please Type Title..."
        bodyField.backgroundColor = .secondarySystemBackground
        bodyField.layer.cornerRadius = 8.0
        bodyField.layer.borderWidth = 1.0
        bodyField.layer.borderColor = UIColor.secondaryLabel.cgColor
        view.addSubview(bodyField)
        let createButton = UIButton(type: UIButton.ButtonType.system)
        createButton.frame = CGRect(x: 16,
                                    y: 250,
                                    width: 100,
                                    height: 48)
        createButton.titleLabel?.text = "Create"
        view.addSubview(createButton)
    }
}
