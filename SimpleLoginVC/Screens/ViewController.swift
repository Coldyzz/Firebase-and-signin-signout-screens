//
//  ViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 23.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let whiteView = whiteView
        whiteView!.layer.cornerRadius = 16
       
    }
    @IBAction func signinClicked(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
    }
}

