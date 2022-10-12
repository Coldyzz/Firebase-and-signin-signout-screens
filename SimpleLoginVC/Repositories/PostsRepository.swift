//
//  PostsRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 04.10.2022.
//

import Foundation
import FirebaseFirestore

struct Post: Codable {
    let id: String
    let title: String
}

protocol PostsRepository {
    func getAll(completion: @escaping ([Post]) -> Void)
}

class FirebasePostsRepository: PostsRepository {
    func getAll(completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("posts").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else {
                completion([])
                return
            }
            var posts: [Post] = []
            for doc in docs {
                let id = doc.documentID
                let data = doc.data()
                guard let title = data["title"] as? String else {
                    continue
                }
                let post = Post(id: id, title: title)
                posts.append(post)
            }
            completion(posts)
        }
    }
}

class DummyPostsRepository: PostsRepository {
    func getAll(completion: ([Post]) -> Void) {
        completion([Post(id: "post1", title: "Welcome in the hood"), Post(id: "post2", title: "Get your pizza")])
    }
}
