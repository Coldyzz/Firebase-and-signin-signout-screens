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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTable.dataSource = self
        
        postsRepository.getAll { posts in
            self.posts = posts
            postsTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
