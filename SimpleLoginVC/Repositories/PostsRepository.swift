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
    @DocumentID var id: String?
    let title: String
    let created: Date
}

protocol PostsRepository {
    func getAll(completion: @escaping ([Post]) -> Void)
    func create(value: Post, completion: @escaping (Post?) -> Void)
    func update(value: Post, completion: @escaping (Post?) -> Void)
    func delete(value: Post, completion: @escaping (Post?) -> Void)
}
// CRUD (Create Read Update Delete)
class FirebasePostsRepository: PostsRepository {
    // можно сократить пару строк
    /*lazy var postsCollection: CollectionReference = {
     return Firestore.firestore().collection("posts")
     }()*/
    func delete(value: Post, completion: @escaping (Post?) -> Void) {
        guard let documentID = value.id else {
            completion(nil)
            return
        }
        Firestore.firestore().collection("posts").document(documentID).delete() { error in
            if error == nil {
                completion(Post(id: value.id,
                                title: value.title,
                                created: value.created))
            } else {
                completion(nil)
            }
        }
    }
    func update(value: Post, completion: @escaping (Post?) -> Void) {
        guard let documentID = value.id else {
            completion(nil)
            return
        }
        try? Firestore
            .firestore()
            .collection("posts")
            .document(documentID)
            .setData(from: value) {error in
                if error == nil {
                    completion(Post(id: value.id,
                                    title: value.title,
                                    created: value.created))
                } else {
                    completion(nil)
                }
            }
    }
    func create(value: Post, completion: @escaping (Post?) -> Void) {
        guard let reference = try? Firestore
            .firestore().collection("posts")
            .addDocument(from: value) else {
            completion(nil)
            return
        }
        completion(Post(id: reference.documentID,
                        title: value.title,
                        created: value.created))
        // пример для работы с другими серверами
        /* try? Firestore.firestore().collection("posts").addDocument(from: value) {error in
         if error == nil {
         completion(Post(id: value.id,
         title: value.title,
         created: value.created))
         } else {
         completion(nil)
         }
         } */
    }
    func getAll(completion: @escaping ([Post]) -> Void) {
        Firestore.firestore()
            .collection("posts")
            .getDocuments { snapshot, _ in
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
