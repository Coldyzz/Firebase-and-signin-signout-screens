//
//  PostsRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 04.10.2022.
//

import Foundation

struct Post: Codable {
    let id: String
    let title: String
}

protocol PostsRepository {
    func getAll(completion: ([Post]) -> Void)
}

class FirebasePostsRepository: PostsRepository {
    func getAll(completion: ([Post]) -> Void) {
    }
}

class DummyPostsRepository: PostsRepository {
    func getAll(completion: ([Post]) -> Void) {
        completion([Post(id: "post1", title: "Welcome in the hood"), Post(id: "post2", title: "Get your pizza")])
    }
}
