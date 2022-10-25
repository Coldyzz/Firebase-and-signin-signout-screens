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
        // field.backgroundColor = .systemBackground
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 0.5
        // field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 8,
                              y: 175,
                              width: 160,
                              height: 48)
        if mode == NewPostMode.create {
            button.setTitle("Create", for: .normal)
            button.addTarget(self, action: #selector(onCreateClicked), for: .touchUpInside)
        } else {
            button.setTitle("Update", for: .normal)
            button.addTarget(self, action: #selector(onUpdateClicked), for: .touchUpInside)
        }
        return button
    }()
    lazy var backgroundContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        if mode == NewPostMode.create {
            title = "Create New Post"
        } else {
            title = "Update Post"
        }
        view.addSubview(backgroundContainer)
        backgroundContainer.addSubview(titleField)
        backgroundContainer.addSubview(createButton)
        backgroundContainer.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                   multiplier: 0.95).isActive = true
        backgroundContainer.heightAnchor.constraint(equalTo: backgroundContainer.widthAnchor).isActive = true
        backgroundContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleField.widthAnchor.constraint(equalTo: backgroundContainer.widthAnchor,
                                          multiplier: 0.9).isActive = true
        titleField.centerXAnchor.constraint(equalTo: backgroundContainer.centerXAnchor).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleField.topAnchor.constraint(equalTo: backgroundContainer.topAnchor,
                                        constant: 100).isActive = true
        createButton.topAnchor.constraint(equalTo: titleField.bottomAnchor,
                                          constant: 16).isActive = true
        createButton.centerXAnchor.constraint(equalTo: titleField.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        titleField.text = editPost?.title
    }
    @objc func onCreateClicked() {
        guard let title = titleField.text,
              title.count > 3 else {
            return
        }
        let newPost = postsRepository.create(title: title, attachments: nil)
        self.onCreateCompletion?(newPost)
        self.navigationController?.popViewController(animated: true)
        /*
         postsRepository.create(value: Post(title: title,created: Date.now)) { [weak self] newPost in
            self?.onCreateCompletion?(newPost)
            self?.navigationController?.popViewController(animated: true)
        }
        */
    }
    @objc func onUpdateClicked() {
        guard let oldPost = editPost,
              let title = titleField.text, title.count > 3 else {
            return
        }
        let updatePost = Post(id: oldPost.id,
                              title: title,
                              created: oldPost.created,
                              authorId: oldPost.authorId,
                              attachments: oldPost.attachments)
        postsRepository.update(value: updatePost)
        self.onUpdateCompletion?(updatePost)
        self.navigationController?.popViewController(animated: true)
        /*
        postsRepository.update(value: Post(id: post.id,
                                           title: title,
                                           created: post.created)) { [weak self] updatedPost in
            self?.onUpdateCompletion?(updatedPost)
            self?.navigationController?.popViewController(animated: true)
        }
        */
    }
}
