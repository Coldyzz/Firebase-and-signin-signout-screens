//
//  SetupProfileViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 25.10.2022.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    let profilesRepository: UserProfilesRepository = FirebaseUserProfilesRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func continueClicked(_ sender: Any) {
        guard let firstName = firstNameField.text else {
            return
        }
        guard let lastName = lastNameField.text else {
            return
        }
        guard let birthday = birthdayField.text else {
            return
        }
        guard let state = stateField.text else {
            return
        }
        guard let city = cityField.text else {
            return
        }
        
        let profile = UserProfile(firstName: firstName,
                                  lastName: lastName,
                                  birthday: Date(),
                                  address: Address(city: city, state: state))
        profilesRepository.create(profile: profile)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ctl = storyboard.instantiateViewController(withIdentifier: "homeViewController")
        navigationController?.pushViewController(ctl, animated: true)
    }
}
