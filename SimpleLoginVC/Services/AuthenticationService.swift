//
//  AuthenticationService.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 26.09.2022.
//

import Foundation
import FirebaseAuth

protocol AuthenticationService {
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void)
    func logout()
    func isAuthenticated () -> Bool
}

class FirebaseAuthenticationService: AuthenticationService {

    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, _ in
            if result?.user != nil {
                UserDefaults.standard.set(true, forKey: "USER_OK")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, _ in
            if result?.user != nil {
                UserDefaults.standard.set(true, forKey: "USER_OK")
                completion(true)
            } else {
                completion(false)
            }
        }    }
    func logout() {
        try? Auth.auth().signOut()
    }
    func isAuthenticated() -> Bool {
        let hasUser = UserDefaults.standard.bool(forKey: "USER_OK")
        return hasUser
    }
    func forgotPassword() {
       // Auth.auth().sendPasswordReset(withEmail: email) { <#Error?#> in
       //     <#code#>
       // }
    }
}
