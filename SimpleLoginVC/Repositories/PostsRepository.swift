//
//  PostsRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 04.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Codable {
    //let id: String
    let title: String
    let created: Date
}

protocol PostsRepository {
    func getAll(completion: @escaping ([Post]) -> Void)
    func create(value: Post, completion: @escaping (Post?) -> Void)
    func update(value: Post, completion: @escaping (Post?) -> Void)
}

class FirebasePostsRepository: PostsRepository {
    func update(value: Post, completion: @escaping (Post?) -> Void) {
        try? Firestore.firestore()
            .collection("posts")
            .document("lv8EBOArvAHNffPujyC0")
            .setData(from: value) {error in
                if error == nil {
                    completion(Post(title: value.title, created: value.created))
                } else {
                    completion(nil)
                }
            }
    }
    func create(value: Post, completion: @escaping (Post?) -> Void) {
        try? Firestore.firestore().collection("posts").addDocument(from: value) {error in
            if error == nil {
                completion(Post(title: value.title, created: value.created))
            } else {
                completion(nil)
            }
        }
    }
    func getAll(completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("posts").getDocuments { snapshot, _ in
            guard let docs = snapshot?.documents else {
                completion([])
                return
            }
            var posts: [Post] = []
            for doc in docs {
                guard let post = try? doc.data(as: Post.self) else {
                    continue
                }
                // пример без использования firestoreswift
                /*let id = doc.documentID
                 let data = doc.data()
                 guard let title = data["title"] as? String else {
                 continue
                 }
                 let post = Post(id: id, title: title) */
                posts.append(post)
            }
            completion(posts)
        }
    }
}
// пример заглушки
/*class DummyPostsRepository: PostsRepository {
    func getAll(completion: ([Post]) -> Void) {
        completion([Post(id: "post1", title: "Welcome in the hood"), Post(id: "post2", title: "Get your pizza")])
    }
}*/
