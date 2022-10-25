//
//  HomeViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 04.10.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var postsTable: UITableView!
    let postsRepository: PostsRepository = FirebasePostsRepository()
    var posts: [Post] = []
    let authenticationService: AuthenticationService = FirebaseAuthenticationService()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        navigationItem.hidesBackButton = true
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Log Out",
                                                              style: UIBarButtonItem.Style.plain,
                                                              target: self,
                                                              action: #selector(logoutClicked)),
                                              UIBarButtonItem(title: "Create",
                                                              style: UIBarButtonItem.Style.plain,
                                                              target: self,
                                                              action: #selector(createClicked))]
        postsTable.dataSource = self
        postsTable.delegate = self
        postsTable.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postRow")
        reloadPosts()
    }
    @objc func logoutClicked() {
        authenticationService.logout()
        // теперь делем проверку для навигейшена сколько экранов в списке
        if navigationController?.viewControllers.count == 1 {
            guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "logInViewController") else {
                return
            }
            navigationController?.pushViewController(loginVC, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    @objc func createClicked() {
        let newPostController = NewPostViewController()
        newPostController.onCreateCompletion = { newPost in
            // перезагружаем все посты
            // self?.reloadPosts()
            if let post = newPost {
                self.posts.append(post)
                self.postsTable.reloadData()
            }
        }
        navigationController?.pushViewController(newPostController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postRow",
                                                       for: indexPath) as? PostCell else {
            fatalError("Cell is not expected type")
        }
        cell.post = posts[indexPath.row]
        cell.onDeleteCompletion = { postToDelete in
            self.postsRepository.delete(postId: postToDelete.id!)
            self.posts.remove(at: indexPath.row)
            self.postsTable.reloadData()
            /*
            { deletedPost in
                self.posts.remove(at: indexPath.row)
                self.postsTable.reloadData()
            }
            */
        }
        return cell
    }
    func reloadPosts() {
        postsRepository.getAll { posts in
            self.posts = posts
            self.postsTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let postToUpdate = posts[index]
        let updatePostController = NewPostViewController()
        updatePostController.editPost = postToUpdate
        updatePostController.mode = NewPostMode.edit
        updatePostController.onUpdateCompletion = { updatedPost in
            if let post = updatedPost {
                self.posts[index] = post
                self.postsTable.reloadData()
            }
        }
        navigationController?.pushViewController(updatePostController, animated: true)
    }
}
