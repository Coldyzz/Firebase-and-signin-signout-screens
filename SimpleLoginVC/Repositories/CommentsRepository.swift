//
//  CommentsRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 24.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol CommentsRepository {
    func getAll(postID: String)
}
