//
//  AuthenticationService.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 26.09.2022.
//

import Foundation

protocol AuthenticationService {
    func signIn(email: String, password: String) -> Void
    
    func signUp(email: String, password: String) -> Void
}
class FirebaseAuthenticationService: AuthenticationService {
    func signIn(email: String, password: String) {
        
    }
    
    func signUp(email: String, password: String) {
        
    }
    
    
}
