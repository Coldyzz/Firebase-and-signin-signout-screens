//
//  AuthenticationService.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 26.09.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

protocol AuthenticationService {
    func signIn(email: String, password: String, completion: @escaping (String?) -> Void)
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void)
    func logout()
    func isAuthenticated () -> Bool
}

class FirebaseAuthenticationService: AuthenticationService {

    func signIn(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if result?.user != nil {
                UserDefaults.standard.set(true, forKey: "USER_OK")
                completion(nil)
            } else {
                let massage = error?.localizedDescription
                completion(massage)
            }
        }
    }
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if result?.user != nil {
                UserDefaults.standard.set(true, forKey: "USER_OK")
                completion(nil)
            } else {
                let massage = error?.localizedDescription
                completion(massage)
            }
        }
    }
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
