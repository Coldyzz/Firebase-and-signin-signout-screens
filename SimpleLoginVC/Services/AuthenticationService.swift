//
//  AuthenticationService.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 26.09.2022.
//

import Foundation
import FirebaseAuth

protocol AuthenticationService {
    func signIn(email: String, password: String, completion: @escaping (String?) -> Void)
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void)
    func forgotPassword(email: String, completion: @escaping (String?) -> Void)
    func logout() -> Bool
    func isAuthenticated() -> Bool
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
    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    func isAuthenticated() -> Bool {
        /* let hasUser = UserDefaults.standard.bool(forKey: "USER_OK")
         return hasUser */
        let hasUser = Auth.auth().currentUser != nil
        return hasUser
    }
    func forgotPassword(email: String, completion: @escaping (String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error?.localizedDescription)
        }
    }
}
