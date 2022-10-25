//
//  UserProfilesRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 24.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct Address: Codable {
    let city: String
    let state: String
}
struct UserProfile: Codable {
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let birthday: Date
    let address: Address
}

protocol UserProfilesRepository {
    func getAll()
    func getOne(userID: String, completion: @escaping (UserProfile?) -> Void)
    func create(profile: UserProfile)
    func update()
}

class FirebaseUserProfilesRepository: UserProfilesRepository {
    func getAll() {
    }
    func getOne(userID: String, completion: @escaping (UserProfile?) -> Void) {
        try? Firestore.firestore().collection("profiles").document(userID).getDocument(as: UserProfile.self) {
            snapshot in
            switch(snapshot) {
            case .success(let profile):
                completion(profile)
            case .failure(_):
                completion(nil)
            }
        }
    }
    func create(profile: UserProfile) {
        var userProfile = profile
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            fatalError("Only Authenticated Users Allowed To Keep Going")
        }
        userProfile.id = currentUserId
        try? Firestore.firestore().collection("profiles").document(currentUserId).setData(from: userProfile)
    }
    func update() {
    }
}
