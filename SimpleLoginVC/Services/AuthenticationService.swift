//
//  AuthenticationService.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 26.09.2022.
//

import Foundation
import FirebaseAuth

protocol AuthenticationService {
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) -> Void
    
    func signUp(email: String, password: String) -> Void
}
class FirebaseAuthenticationService: AuthenticationService {
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if result?.user != nil {
                completion(true)
            } else {
                completion(false)
            }
            //print("\(#file) \(#function): UserID = \(result?.user.uid)")
            // print("\(#file) \(#function): Failed \(error)")
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password)
    }
    
    
}
