//
//  PostCell.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 05.10.2022.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    let profilesRepository: UserProfilesRepository = FirebaseUserProfilesRepository()
    let authenticatedService: AuthenticationService = FirebaseAuthenticationService()
    var post: Post! {
        didSet {
            titleLabel.text = post.title
            profilesRepository.getOne(userID: post.authorId) { profile in
                guard let profile = profile else {
                    return
                }
                self.authorLabel.text = "\(profile.firstName) \(profile.lastName)"
            }
            let currentUser = authenticatedService.currentUserId()
            if post.authorId == currentUser {
                deleteButton.isHidden = false
            } else {
                deleteButton.isHidden = true
            }
        }
    }
    var onDeleteCompletion: ((Post) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func deleteClicked(_ sender: Any) {
        onDeleteCompletion?(post)
    }
}
