//
//  HomeViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 04.10.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var postsTable: UITableView!
    let postsRepository: PostsRepository = DummyPostsRepository()
    var posts: [Post] = []
    let authenticationService: AuthenticationService = FirebaseAuthenticationService()
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTable.dataSource = self
        postsTable.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postRow")
        postsRepository.getAll { posts in
            self.posts = posts
            postsTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postRow",
                                                       for: indexPath) as? PostCell else {
            fatalError("Cell is not expected type")
        }
        cell.post = posts[indexPath.row]
        return cell
    }
    @IBAction func logoutClicked(_ sender: Any) {
        authenticationService.logout()
    }
}
