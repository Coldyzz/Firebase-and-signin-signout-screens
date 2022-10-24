//
//  ReactionsRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 24.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum ReactionType: Codable {
    case smile, tears, rocket, applause
}
struct Reaction: Codable {
    @DocumentID var id: String?
    let type: ReactionType
    let created: Date
    let postID: String
    let authorID: String
}

protocol ReactionsRepository {
    func getAll(postID: String)
    func create(postID: String)
    func delete(postID: String, id: String)
}
