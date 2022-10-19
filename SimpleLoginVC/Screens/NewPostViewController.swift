//
//  NewPostViewController.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 11.10.2022.
//

import UIKit

enum NewPostMode {
    case create, edit
}

class NewPostViewController: UIViewController {
    var onCreateCompletion: ((Post?) -> Void)?
    var onUpdateCompletion: ((Post?) -> Void)?
    var editPost: Post?
    var mode: NewPostMode = NewPostMode.create
    let postsRepository: PostsRepository = FirebasePostsRepository()
    lazy var  titleField: UITextField = {
        let field = UITextField(frame: CGRect(x: 16,
                                              y: 100,
                                              width: 200,
                                              height: 48))
        field.placeholder = "Please Type Title..."
        // field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    lazy var createButton: UIButton = {
        let createButton = UIButton(type: .system)
        createButton.frame = CGRect(x: 8,
                                    y: 175,
                                    width: 160,
                                    height: 48)
        if mode == NewPostMode.create {
            createButton.setTitle("Create", for: .normal)
            createButton.addTarget(self, action: #selector(onCreateClicked), for: .touchUpInside)
        } else {
            createButton.setTitle("Update", for: .normal)
            createButton.addTarget(self, action: #selector(onUpdateClicked), for: .touchUpInside)
        }
        return createButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if mode == NewPostMode.create {
            title = "Create New Post"
        } else {
            title = "Update Post"
        }
        view.addSubview(titleField)
        titleField.text = editPost?.title
        view.addSubview(createButton)
        titleField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                          multiplier: 0.8).isActive = true
        titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleField.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 100).isActive = true
        createButton.topAnchor.constraint(equalTo: titleField.bottomAnchor,
                                          constant: 16).isActive = true
        createButton.centerXAnchor.constraint(equalTo: titleField.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }
    @objc func onCreateClicked() {
        guard let title = titleField.text,
              title.count > 3 else {
            return
        }
        postsRepository.create(value: Post(title: title,
                                           created: Date.now)) { [weak self] newPost in
            self?.onCreateCompletion?(newPost)
            self?.navigationController?.popViewController(animated: true)
        }
    }
    @objc func onUpdateClicked() {
        guard let post = editPost,
              let title = titleField.text, title.count > 3 else {
            return
        }
        postsRepository.update(value: Post(id: post.id,
                                           title: title,
                                           created: post.created)) { [weak self] updatedPost in
            self?.onUpdateCompletion?(updatedPost)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
