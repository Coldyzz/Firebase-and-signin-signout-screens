//
//  PostsRepository.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 04.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

enum AttachmentType: Codable {
    case photo, video, link
}
struct Attachment: Codable {
    let type: AttachmentType
    let url: URL
}
struct Post: Codable {
    @DocumentID var id: String?
    let title: String
    @ServerTimestamp var created: Date?
    let authorId: String
    let attachments: [Attachment]?
}

protocol PostsRepository {
    func getAll(completion: @escaping ([Post]) -> Void)
    func create(title: String, attachments: [Attachment]?) -> Post
    func update(value: Post)
    func delete(postId: String)
}
class FirebasePostsRepository: PostsRepository {
    // можно сократить пару строк
    /*lazy var postsCollection: CollectionReference = {
     return Firestore.firestore().collection("posts")
     }()*/
    func delete(postId: String) {
        Firestore.firestore().collection("posts").document(postId).delete()
    }
    func update(value: Post) {
        guard let documentID = value.id else {
            return
        }
        try? Firestore.firestore().collection("posts").document(documentID).setData(from: value)
    }
    func create(title: String, attachments: [Attachment]?) -> Post {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            fatalError("Only Authenticated Users Allowe To Create Posts")
        }
        var post = Post(title: title, authorId: currentUserId, attachments: attachments)
        guard let reference = try? Firestore.firestore().collection("posts").addDocument(from: post) else {
            fatalError("Failed To Create New Post")
        }
        post.id = reference.documentID
        return post
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
                    posts.append(post)
                }
                completion(posts)
            }
    }
}
