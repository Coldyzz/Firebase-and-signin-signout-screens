//
//  NewPostViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 11.10.2022.
//

import UIKit

class NewPostViewController: UIViewController {
    var onCreateCompletion: ((Post?) -> Void)?
    let postsRepository: PostsRepository = FirebasePostsRepository()
    lazy var  titleField: UITextField = {
        let field = UITextField(frame: CGRect(x: 16,
                                              y: 100,
                                              width: 200,
                                              height: 48))
        field.placeholder = "Please Type Title..."
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create New Post"
        view.addSubview(titleField)
        let createButton = UIButton(type: .system)
        createButton.frame = CGRect(x: 8,
                                    y: 175,
                                    width: 100,
                                    height: 48)
        createButton.setTitle("Create", for: .normal)
        createButton.addTarget(self, action: #selector(onCreateClicked), for: .touchUpInside)
        view.addSubview(createButton)
    }
    @objc func onCreateClicked() {
        guard let title = titleField.text, title.count > 3 else {
            return
        }
        postsRepository.create(value: Post(title: title, created: Date.now)) { [weak self] newPost in
            self?.onCreateCompletion?(newPost)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
