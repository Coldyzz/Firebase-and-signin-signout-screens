//
//  UserProfilesRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 24.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

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
    func getOne(userID: String)
    func update()
    func delete()
}
