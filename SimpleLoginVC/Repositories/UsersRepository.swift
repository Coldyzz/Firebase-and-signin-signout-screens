//
//  UsersRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 24.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UsersRepository {
    func getAll()
    func getOne(userID: String)
    func update()
    func delete()
}
